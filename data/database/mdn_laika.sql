-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Sep 14, 2017 at 09:41 AM
-- Server version: 5.5.42
-- PHP Version: 5.4.42

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mdn_laika`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL DEFAULT '',
  `category_parent` int(11) NOT NULL DEFAULT '0',
  `category_order` int(3) DEFAULT '0',
  `category_url` varchar(255) DEFAULT '',
  `category_highlight` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `category_parent`, `category_order`, `category_url`, `category_highlight`) VALUES
(1, 'Laika', 0, 0, '', 0),
(2, 'Rubro1', 0, 0, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `shorttitle` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `cuit` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `creation_userid` int(11) NOT NULL,
  `modification_date` datetime NOT NULL,
  `modification_userid` int(11) DEFAULT NULL,
  `state` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `title`, `shorttitle`, `description`, `cuit`, `phone`, `address`, `email`, `website`, `creation_date`, `creation_userid`, `modification_date`, `modification_userid`, `state`) VALUES
(11, 'MTV ', 'mtv-', '', '', '', '', '', '', '2014-08-10 10:55:00', 0, '0000-00-00 00:00:00', 17, 0),
(10, 'Autopistas del Sol S.A.       ', 'autopistas-del-sol-sa--', '', '30-67723711-9', '5789.8757', 'PANAMERICANA 2451 - BOULOGNE (B1609JVF)', 'helorriaga@ausol.com.ar', 'https://www.ausol.com.ar/ ', '2014-08-08 11:54:33', 0, '0000-00-00 00:00:00', 16, 0),
(4, 'Paka Paka', 'paka-paka', '', '30-32424234-0', 'xxx', 'xx', '', '', '2014-07-03 17:33:34', 0, '0000-00-00 00:00:00', NULL, 0),
(9, 'Ministerio de Cultura de la Nación', 'ministerio-de-cultura-de-la-nacion', '', '', '', 'Alvear 1690', '', '', '2014-08-07 20:18:20', 0, '0000-00-00 00:00:00', 16, 0),
(8, 'Educ.ar', 'educar', '', '', '47044000', 'Comodoro Rivadavia 1151', '', '', '2014-07-30 18:31:43', 0, '0000-00-00 00:00:00', 17, 0),
(12, 'AD ONE', 'ad-one', '', '', '', '', '', '', '2014-08-10 10:55:20', 0, '0000-00-00 00:00:00', NULL, 0),
(13, 'AGUAS DANONE DE ARGENTINA S.A.', 'aguas-danone-de-argentina-sa', '', '30-51705022-5', '', 'Moreno 600', '', '', '2014-09-04 16:19:17', 0, '0000-00-00 00:00:00', 18, 0),
(14, 'Autopistas del Oeste', 'autopistas-del-oeste', '', '304999594-1', '', '', '', '', '2015-08-19 22:35:02', 0, '0000-00-00 00:00:00', 18, 0),
(15, 'AUSOL', 'ausol', '', '30-20300404-2', '', '', '', '', '2015-10-20 15:33:02', 0, '0000-00-00 00:00:00', 18, 0),
(16, 'PRODUCTOS ROCHE S A QUIMICA E INDUSTRIAL', 'productos-roche-s-a-quimica-e-industrial', '', '30527444280', '54 11 5129 8200', 'Rawson 3150 B1610BAL, Ricardo Rojas, Buenos Aires, Argentina', '', '', '2015-12-02 12:34:18', 0, '0000-00-00 00:00:00', 18, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cobro`
--

DROP TABLE IF EXISTS `cobro`;
CREATE TABLE `cobro` (
  `id` int(11) NOT NULL,
  `number` varchar(100) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `description` text,
  `amount` decimal(10,2) DEFAULT NULL,
  `date` date NOT NULL,
  `state` int(1) NOT NULL DEFAULT '0',
  `provider_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL,
  `creation_userid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cobro`
--

INSERT INTO `cobro` (`id`, `number`, `type`, `description`, `amount`, `date`, `state`, `provider_id`, `project_id`, `creation_userid`) VALUES
(3, '001-2322', 'A', 'desc   ', '121212.00', '2015-08-28', 0, 56, 0, 1),
(4, '121213', 'B', 'desc     ', '15555.63', '2015-07-10', 0, 34, 0, 1),
(5, '121214', 'A', '   Cobro canal   ', '2000.00', '2015-05-07', 1, 46, 0, 1),
(6, '12-2012', 'A', 'Adelanto factura al GCO   ', '15000.00', '2015-07-08', 0, 24, 0, 18),
(7, '3456', 'A', ' test ', '55000.00', '2015-08-25', 0, 29, 0, 12);

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL,
  `objecttype_id` int(11) NOT NULL DEFAULT '1',
  `object_id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `comment_content` text,
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `state_id` int(1) NOT NULL DEFAULT '1',
  `user_report` int(11) NOT NULL DEFAULT '0',
  `motive_report` varchar(255) DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `costo_operativo`
--

DROP TABLE IF EXISTS `costo_operativo`;
CREATE TABLE `costo_operativo` (
  `id` int(11) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `amount` decimal(10,0) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `costo_operativo`
--

INSERT INTO `costo_operativo` (`id`, `title`, `amount`) VALUES
(11, 'Teléfono', '1000'),
(13, 'Gas', '3000'),
(14, 'Alquiler de inmueble', '4000'),
(15, 'Seguros de Accidentes personales', '2000');

-- --------------------------------------------------------

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `partida_id` int(11) NOT NULL,
  `resource_id` int(11) DEFAULT '0',
  `subrubro_id` int(11) NOT NULL DEFAULT '0',
  `number` varchar(100) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `description` text,
  `amount` decimal(10,2) DEFAULT NULL,
  `date` date NOT NULL,
  `state` int(1) NOT NULL DEFAULT '0',
  `payment_date` date NOT NULL,
  `payment_format` varchar(100) NOT NULL,
  `creation_userid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factura`
--

INSERT INTO `factura` (`id`, `project_id`, `provider_id`, `partida_id`, `resource_id`, `subrubro_id`, `number`, `type`, `description`, `amount`, `date`, `state`, `payment_date`, `payment_format`, `creation_userid`) VALUES
(8, 10, 0, 0, 0, 28, '4', 'C', 'Honorarios del Director del Proyecto', '6000.00', '2014-07-10', 1, '0000-00-00', '', 1),
(6, 10, 11, 0, 0, 8, '2', 'A', 'Pago de Luces', '1000.00', '2014-07-10', 1, '0000-00-00', '', 1),
(7, 10, 11, 0, 0, 8, '3', 'A', 'Otra Factura de Luces', '1000.00', '2014-07-10', 1, '0000-00-00', '', 1),
(9, 10, 0, 0, 0, 14, '5', 'A', 'Pago de Flat Car', '1000.00', '2014-07-11', 1, '0000-00-00', '', 1),
(10, 10, 0, 0, 0, 5, '5', 'A', 'Pago Alquiler de Cámaras', '500.00', '2014-07-11', 1, '0000-00-00', '', 1),
(11, 10, 0, 17, 0, 0, '12', 'A', '', '1200.00', '2014-07-12', 1, '0000-00-00', '', 1),
(14, 12, 0, 0, 0, 5, '1', 'A', '', '2000.00', '2014-07-11', 1, '0000-00-00', '', 1),
(12, 10, 11, 11, 0, 0, '6', 'A', 'desc', '15000.00', '2014-07-11', 0, '0000-00-00', '', 1),
(13, 10, 0, 10, 0, 0, '9', 'A', 'desc', '1000.00', '2014-07-18', 0, '0000-00-00', '', 1),
(16, 29, 11, 20, 0, 5, '1', 'A', '', '40000.00', '2014-07-22', 1, '0000-00-00', '', 1),
(17, 29, 0, 20, 0, 5, '5', 'A', '', '30000.00', '2014-07-23', 1, '0000-00-00', '', 1),
(18, 29, 0, 0, 0, 44, '3', 'A', '', '800.00', '2014-07-23', 1, '0000-00-00', '', 1),
(19, 29, 0, 0, 0, 11, '4', 'A', '', '1200.00', '2014-07-22', 1, '0000-00-00', '', 1),
(20, 29, 0, 0, 0, 8, '2', 'A', '', '1000.00', '2014-07-22', 1, '0000-00-00', '', 1),
(21, 34, 0, 0, 0, 43, '121', 'A', '', '2500.00', '2014-07-31', 1, '0000-00-00', '', 1),
(22, 34, 35, 0, 0, 43, '', 'A', '', '1000.00', '0000-00-00', 0, '0000-00-00', '', 1),
(23, 34, 0, 24, 0, 0, '', 'B', '', '15.00', '0000-00-00', 1, '0000-00-00', '', 1),
(26, 39, 22, 0, 196, 5, '123', 'A', '', '3000.00', '2014-08-15', 1, '0000-00-00', '', 1),
(27, 39, 43, 0, 195, 29, '', 'Sin Compro', '', '3000.00', '2014-08-16', 1, '0000-00-00', '', 1),
(28, 38, 0, 31, 233, 116, '', 'A', 'Alquiler de terraza en inmobiliaria de Beiro para cámara 2 de timelapse.  ', '1000.00', '2014-09-03', 1, '0000-00-00', '', 18),
(29, 38, 0, 31, 233, 116, '2-00045739', 'A', 'Gastos ferreteria para instalacion cámara Beiro # 2. inmobiliaria  ', '88.05', '2014-08-27', 1, '0000-00-00', '', 18),
(30, 38, 0, 31, 233, 116, '2063', 'A', 'Gastos varios electricidad para instalacion cámara en Beiro # 2, inmobiliaria.  ', '128.50', '2014-08-21', 1, '0000-00-00', '', 18),
(31, 38, 40, 31, 169, 96, '04-33138', 'A', 'Gastos por utilizar el auto de Jorge Coki Tristan por el mes de Agosto  ', '540.04', '2014-08-19', 1, '0000-00-00', '', 18),
(32, 38, 40, 31, 161, 95, '', 'Ticket', 'Almuerzo luego de las 2 reuniones en Occovi miercoles 3 ', '60.00', '2014-09-03', 1, '0000-00-00', '', 18),
(33, 38, 40, 31, 169, 96, '', 'Ticket', 'Garage por haber ido en auto al centro, luego de la reunión de Olivos ', '114.00', '2014-09-03', 1, '0000-00-00', '', 18),
(34, 38, 0, 31, 233, 116, '3-00002488', 'A', 'Compra de accesorios de la impresora de produ  ', '8.00', '2014-09-03', 1, '0000-00-00', '', 18),
(36, 38, 40, 31, 169, 96, '', 'Ticket', 'Taxi regreso de Saavedra a la productora Ezequiel - mantenimiento Timelapse ', '40.04', '2014-09-03', 1, '0000-00-00', '', 18),
(37, 38, 40, 31, 169, 96, '', 'Ticket', 'peaje al centro', '6.00', '2014-09-03', 1, '0000-00-00', '', 18),
(38, 38, 40, 31, 161, 95, '3184-00002208', 'A', 'merienda rodaje Ausol ', '71.00', '2014-08-22', 1, '0000-00-00', '', 18),
(39, 38, 0, 31, 233, 116, '1075-0000155', 'A', 'compra de pilas camaras time lapse', '114.00', '2014-08-23', 1, '0000-00-00', '', 18),
(40, 38, 40, 31, 169, 96, '1073-00009021', 'A', 'mantenimiento Ezequiel camaras time lapse', '100.00', '2014-08-25', 1, '0000-00-00', '', 18),
(41, 38, 40, 31, 169, 96, '974-0011038', 'A', 'Mantenimiento Time lapse + viaje a Ausol reunio seguridad e higiene', '206.17', '2014-08-27', 1, '0000-00-00', '', 18),
(42, 38, 40, 31, 169, 96, '974-00011126', 'A', 'Mantenimiento time lapse  ', '100.00', '2014-08-30', 1, '0000-00-00', '', 18),
(48, 38, 39, 0, 144, 17, '', 'C', 'Factura Fernando Mollica Agosto  ', '19000.00', '2014-09-08', 0, '0000-00-00', '', 18),
(44, 38, 40, 31, 161, 95, '', 'Sin Compro', 'comida rodaje Ausol', '165.00', '2014-08-22', 1, '0000-00-00', '', 18),
(46, 38, 40, 31, 161, 95, '', 'Sin Compro', 'Propina Almuerzo', '10.00', '2014-08-22', 1, '0000-00-00', '', 18),
(47, 38, 40, 31, 169, 96, '', 'Ticket', '3 peajes de $6', '18.00', '2014-08-27', 1, '0000-00-00', '', 18),
(49, 38, 41, 0, 177, 85, '346', 'C', 'Alquiler stanco Jorge Tristan   ', '1845.00', '2014-09-03', 1, '0000-00-00', '', 18),
(50, 38, 40, 0, 149, 85, '777', 'A', 'Grip Jorge tristan  ', '10500.00', '2014-09-05', 1, '0000-00-00', '', 18),
(51, 38, 40, 0, 145, 40, '2222', 'A', 'Sueldo Gabriel Siperman Agosto', '16520.00', '2014-09-05', 1, '0000-00-00', '', 18),
(53, 38, 40, 0, 176, 41, '2222', 'A', 'Sueldo Ezequiel Kopel ', '10511.00', '2014-09-05', 1, '0000-00-00', '', 18),
(54, 38, 40, 0, 176, 41, '333', 'A', 'Sueldo Ezequiel Kopel Agosto', '10511.00', '2014-09-05', 1, '0000-00-00', '', 18),
(55, 38, 40, 0, 146, 82, '32323', 'A', 'Sueldo Hernan Bento Gago', '16000.00', '2014-09-05', 1, '0000-00-00', '', 18),
(56, 38, 40, 0, 150, 56, '39393', 'A', 'Sueldo editor EPL', '9100.00', '2014-09-05', 1, '0000-00-00', '', 18),
(57, 38, 40, 0, 162, 97, '3343', 'A', 'Auxiliar administrativo', '2500.00', '2014-09-05', 1, '0000-00-00', '', 18),
(60, 38, 40, 0, 164, 100, '', '', 'servicios Varios', '2000.00', '2014-09-05', 1, '0000-00-00', '', 18),
(59, 38, 40, 0, 163, 99, '333', 'A', 'mensajeria Agosto', '1200.00', '2014-09-05', 1, '0000-00-00', '', 18),
(61, 38, 40, 0, 168, 31, '', '', 'telefonia', '1294.00', '2014-09-05', 1, '0000-00-00', '', 18),
(62, 38, 40, 0, 156, 5, '', 'A', 'Alquiler camara Agosto', '3000.00', '2014-09-05', 1, '0000-00-00', '', 18),
(63, 38, 40, 0, 158, 11, '', '', 'carro', '600.00', '2014-09-05', 1, '0000-00-00', '', 18),
(64, 38, 40, 0, 159, 90, '', 'A', 'alquiler Agosto ', '1200.00', '0000-00-00', 0, '0000-00-00', '', 18),
(66, 38, 42, 0, 166, 76, '', 'C', 'Seguros varios  ', '1200.00', '2014-09-05', 1, '0000-00-00', '', 18),
(67, 46, 50, 0, 267, 119, '191', 'C', 'Diseño creativos', '12000.00', '2014-08-29', 0, '0000-00-00', '', 18),
(68, 46, 12, 0, 266, 118, '', 'C', 'Fer Salem', '11000.00', '2014-08-31', 0, '0000-00-00', '', 18),
(69, 33, 12, 0, 136, 28, '109', 'C', 'Dirección spot', '10000.00', '2014-07-30', 0, '0000-00-00', '', 17),
(70, 33, 0, 0, 180, 96, '10', 'A', 'Movilidad', '2015.00', '2014-08-03', 0, '0000-00-00', '', 17),
(71, 33, 0, 0, 227, 74, '', 'Sin Compro', 'AAA', '3850.00', '2014-07-30', 0, '0000-00-00', '', 17),
(72, 33, 0, 0, 181, 107, '2067', 'C', 'Arte', '1400.00', '2014-07-29', 0, '0000-00-00', '', 17),
(73, 33, 21, 0, 143, 82, '31', 'C', 'Georgina Pretto', '2000.00', '2014-07-27', 0, '0000-00-00', '', 17),
(74, 33, 25, 0, 171, 63, '171', 'C', '', '3000.00', '2014-08-01', 0, '0000-00-00', '', 17),
(75, 43, 0, 0, 275, 58, '613', 'A', ' ', '2500.00', '0000-00-00', 0, '0000-00-00', '', 15),
(76, 43, 12, 0, 231, 43, '107', 'C', '', '3000.00', '2014-09-09', 0, '0000-00-00', '', 15),
(77, 43, 53, 0, 270, 120, '114', 'C', '', '1500.00', '0000-00-00', 0, '0000-00-00', '', 15),
(78, 43, 52, 0, 268, 119, '358', 'C', '', '5000.00', '0000-00-00', 0, '0000-00-00', '', 15),
(79, 43, 54, 0, 272, 53, '152', 'C', '', '2500.00', '0000-00-00', 0, '0000-00-00', '', 15),
(80, 43, 55, 0, 279, 65, '538', 'A', ' ', '10000.00', '0000-00-00', 0, '0000-00-00', '', 15),
(81, 43, 25, 0, 277, 63, '253', 'C', '', '3000.00', '0000-00-00', 0, '0000-00-00', '', 15),
(82, 43, 25, 0, 278, 64, '250', 'C', '', '600.00', '0000-00-00', 0, '0000-00-00', '', 15),
(83, 49, 29, 0, 287, 43, '', 'A', '  ', '1234.00', '2014-09-14', 0, '0000-00-00', '', 12),
(84, 33, 34, 0, 185, 5, '', '', '', '0.00', '0000-00-00', 0, '0000-00-00', '', 1),
(85, 33, 0, 0, 180, 96, '', '', '', '0.00', '0000-00-00', 0, '0000-00-00', '', 1),
(86, 51, 42, 0, 335, 76, '2333', 'C', '           ', '20000.00', '2016-12-26', 1, '2016-12-26', 'Efectivo', 18),
(87, 51, 58, 0, 314, 41, '531', 'C', ' ', '4000.00', '2015-07-15', 1, '0000-00-00', '', 18),
(88, 51, 0, 0, 315, 40, '334', 'C', ' ', '3000.00', '2015-06-28', 1, '0000-00-00', '', 18),
(89, 51, 52, 0, 324, 87, '677', 'C', '  ', '32000.00', '2015-07-05', 1, '0000-00-00', '', 18),
(90, 51, 0, 0, 327, 125, '393', 'C', ' ', '10018.00', '2015-07-08', 1, '0000-00-00', '', 18),
(91, 51, 42, 0, 335, 76, '456', 'C', ' ', '818.00', '2015-05-13', 1, '0000-00-00', '', 18),
(92, 51, 25, 0, 319, 63, '283', 'C', ' ', '3000.00', '2015-07-08', 1, '0000-00-00', '', 18),
(93, 51, 0, 32, 330, 96, '', 'A', '    ', '320.00', '2015-03-21', 1, '0000-00-00', '', 18),
(94, 51, 0, 32, 330, 96, '564', 'A', '  ', '275.00', '2015-03-23', 1, '0000-00-00', '', 18),
(95, 51, 0, 32, 329, 95, '', 'A', '  ', '190.00', '2015-05-20', 1, '0000-00-00', '', 18),
(96, 51, 0, 32, 330, 96, '', 'A', '   ', '108.00', '2015-05-20', 1, '0000-00-00', '', 18),
(97, 51, 0, 32, 330, 96, '', 'A', '   ', '84.00', '2015-05-20', 1, '0000-00-00', '', 18),
(98, 51, 0, 32, 329, 95, '', 'A', '  ', '215.00', '2015-06-08', 1, '0000-00-00', '', 18),
(99, 51, 0, 32, 329, 95, '', 'Ticket', 'peaje  ', '15.00', '2015-06-02', 1, '0000-00-00', '', 18),
(100, 51, 0, 32, 330, 96, '49494', 'A', 'combustioble  ', '53.51', '2015-06-16', 1, '0000-00-00', '', 18),
(101, 51, 0, 32, 330, 96, 'e4r4r54tt5', 'A', 'Combustible Guido Speroni  ', '390.24', '2015-06-13', 1, '0000-00-00', '', 18),
(102, 51, 0, 32, 329, 95, '384384', 'A', 'facturas reunion  ', '24.00', '2015-06-30', 1, '0000-00-00', '', 18),
(103, 51, 0, 32, 337, 128, '', 'Ticket', '  ', '960.00', '2015-07-03', 1, '0000-00-00', '', 18),
(104, 51, 0, 32, 329, 95, '9393', 'A', ' ', '103.10', '0000-00-00', 1, '0000-00-00', '', 18),
(105, 51, 0, 33, 330, 96, '', 'A', 'Combustible  ', '350.00', '0000-00-00', 1, '0000-00-00', '', 18),
(106, 51, 0, 33, 330, 96, '', 'A', '  ', '380.75', '0000-00-00', 1, '0000-00-00', '', 18),
(107, 51, 0, 33, 330, 96, '666', 'A', '  ', '580.11', '0000-00-00', 1, '0000-00-00', '', 18),
(108, 51, 0, 33, 330, 96, '003w', 'A', '  ', '417.02', '0000-00-00', 1, '0000-00-00', '', 18),
(109, 51, 0, 33, 330, 96, '2003', 'A', '   ', '300.00', '2015-06-23', 1, '0000-00-00', '', 18),
(110, 51, 0, 33, 329, 95, '6667', 'A', '   ', '152.00', '2015-07-06', 1, '0000-00-00', '', 18),
(111, 51, 0, 33, 329, 95, '49494', 'A', '  ', '86.02', '2015-07-06', 1, '0000-00-00', '', 18),
(112, 51, 0, 33, 329, 95, '9595', 'A', '  ', '463.81', '2015-06-20', 1, '0000-00-00', '', 18),
(113, 51, 0, 32, 329, 95, '', 'Ticket', ' ', '75.00', '2015-07-20', 1, '0000-00-00', '', 18),
(114, 51, 0, 32, 329, 95, 'sss', 'A', 'comidas ', '250.00', '0000-00-00', 1, '0000-00-00', '', 18),
(116, 51, 0, 0, 0, 0, '2345', 'A', '', '5000.00', '2015-11-12', 0, '0000-00-00', '', 25),
(117, 51, 0, 33, 0, 0, 'kjhkjhlkhj', 'A', '', '119.40', '2016-12-26', 1, '0000-00-00', '', 1),
(118, 55, 0, 34, 0, 0, '1', 'A', 'desc', '20.00', '2016-12-26', 1, '0000-00-00', '', 1),
(119, 55, 0, 34, 0, 0, '1234', 'A', '    ', '110.00', '2016-12-31', 1, '2016-12-26', 'Efectivo', 1),
(120, 55, 0, 34, 0, 0, '', 'A', '       ', '70.00', '2016-12-28', 1, '0000-00-00', '', 1),
(122, 58, 0, 35, 0, 0, '1201212', 'Ticket', ' ', '3000.00', '2017-09-12', 1, '0000-00-00', '', 1),
(123, 58, 0, 36, 0, 0, 'aaaaa-aaa-aaa', 'C', '', '20000.00', '2017-09-12', 1, '0000-00-00', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `location_name` varchar(255) NOT NULL DEFAULT '',
  `location_parent` int(11) NOT NULL DEFAULT '0',
  `location_order` int(3) DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=2445 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `location_name`, `location_parent`, `location_order`) VALUES
(1, 'Argentina', 0, 1),
(121, 'Catamarca', 1, 8),
(120, 'Capital Federal/GBA', 1, 7),
(119, 'Bs.As. (fuera de GBA)', 1, 6),
(118, 'GBA Sur', 1, 5),
(117, 'GBA Oeste', 1, 4),
(226, 'San Fernando', 116, 0),
(114, 'Capital Federal', 1, 1),
(122, 'Chaco', 1, 9),
(116, 'GBA Norte', 1, 3),
(123, 'Chubut', 1, 10),
(124, 'Córdoba', 1, 11),
(125, 'Corrientes', 1, 12),
(126, 'Entre Ríos', 1, 13),
(127, 'Formosa', 1, 14),
(128, 'Jujuy', 1, 15),
(129, 'La Pampa', 1, 16),
(130, 'La Rioja', 1, 17),
(131, 'Mendoza', 1, 18),
(132, 'Misiones', 1, 19),
(133, 'Neuquén', 1, 20),
(134, 'Otra', 1, 21),
(135, 'Río Negro', 1, 22),
(136, 'Salta', 1, 23),
(137, 'San Juan', 1, 24),
(138, 'San Luis', 1, 25),
(139, 'Santa Cruz', 1, 26),
(140, 'Santa Fe', 1, 27),
(141, 'Santiago Del Estero', 1, 28),
(142, 'Tierra Del Fuego', 1, 29),
(143, 'Tucumán', 1, 30),
(144, 'Exterior', 1, 31),
(146, 'Agronomia', 114, 1),
(147, 'Almagro', 114, 1),
(148, 'Balvanera', 114, 1),
(149, 'Belgrano', 114, 1),
(150, 'Caballito', 114, 1),
(163, 'Barracas', 114, 1),
(152, 'Chacarita', 114, 1),
(153, 'Flores', 114, 1),
(162, 'Abasto', 114, 1),
(155, 'Monserrat', 114, 1),
(156, 'Nuñez', 114, 1),
(157, 'Palermo', 114, 1),
(158, 'Puerto Madero', 114, 1),
(159, 'Recoleta', 114, 1),
(160, 'Retiro', 114, 1),
(161, 'San Telmo', 114, 1),
(164, 'Barrio Norte', 114, 1),
(165, 'Boedo', 114, 1),
(166, 'Coghlan', 114, 1),
(167, 'Colegiales', 114, 1),
(168, 'Constitución', 114, 1),
(169, 'Floresta', 114, 1),
(170, 'La Boca', 114, 1),
(171, 'Liniers', 114, 1),
(172, 'Mataderos', 114, 1),
(173, 'Monte Castro', 114, 1),
(174, 'Nueva Pompeya', 114, 1),
(175, 'Once', 114, 1),
(176, 'Parque Avellaneda', 114, 1),
(177, 'Parque Chacabuco', 114, 1),
(178, 'Parque Patricios', 114, 1),
(179, 'Paternal', 114, 1),
(180, 'Saavedra', 114, 1),
(181, 'San Cristobal', 114, 1),
(182, 'San Nicolas', 114, 1),
(183, 'Velez Sarsfield', 114, 1),
(184, 'Versalles', 114, 1),
(185, 'Villa Crespo', 114, 1),
(186, 'Villa Devoto', 114, 1),
(187, 'Villa General Mitre', 114, 1),
(188, 'Villa Lugano', 114, 1),
(189, 'Villa Luro', 114, 1),
(190, 'Villa Ortuzar', 114, 1),
(191, 'Villa Pueyrredon', 114, 1),
(192, 'Villa Real', 114, 1),
(193, 'Villa Riachuelo', 114, 1),
(194, 'Villa Santa Rita', 114, 1),
(195, 'Villa Soldati', 114, 1),
(196, 'Villa Urquiza', 114, 1),
(197, 'Villa del Parque', 114, 1),
(198, 'Bahía Blanca', 119, 1),
(199, 'La Rioja Capital', 130, 1),
(200, 'Córdoba Capital', 124, 1),
(201, 'Mendoza Capital', 131, 1),
(202, 'San Miguel de Tucumán', 143, 1),
(203, 'Santa Fe Capital', 140, 1),
(204, 'Resistencia', 122, 1),
(205, 'Venado Tuerto', 140, 1),
(206, 'Salta capital', 136, 0),
(207, 'Morón', 117, 0),
(209, 'La Plata', 119, 0),
(210, 'Lanús', 118, 0),
(211, 'La Matanza', 117, 0),
(212, 'Quilmes', 118, 0),
(213, 'San Martín', 116, 0),
(214, 'Mar del Plata', 119, 0),
(215, 'Rosario', 140, 0),
(216, 'Vicente López, Olivos', 116, 0),
(217, 'San Isidro', 116, 0),
(225, 'San Isidro, Villa Adelina', 116, 0),
(221, 'Rafaela', 140, 0),
(222, 'Cañuelas', 119, 0),
(223, 'San Francisco ', 124, 0),
(224, 'Río Grande', 142, 0),
(227, 'Pinamar', 119, 0),
(228, 'Río Cuarto', 124, 0),
(229, 'Pilar', 116, 0),
(230, 'Villa Rosa', 119, 0),
(650, '25 de Mayo', 119, 0),
(651, '30 de Agosto', 119, 0),
(652, '9 de Julio', 119, 0),
(653, 'Acevedo', 119, 0),
(654, 'Adolfo Gonzales Chaves', 119, 0),
(655, 'Alberti', 119, 0),
(656, 'Alsina', 119, 0),
(657, 'Ameghino', 119, 0),
(658, 'Arenaza', 119, 0),
(659, 'Argentino Roca', 119, 0),
(660, 'Arrecifes', 119, 0),
(661, 'Arribeños', 119, 0),
(662, 'Arroyo Dulce', 119, 0),
(663, 'Ascensión', 119, 0),
(664, 'Ayacucho', 119, 0),
(665, 'Azul', 119, 0),
(666, 'Baigorrita', 119, 0),
(667, 'Balcarce', 119, 0),
(668, 'Banderaló', 119, 0),
(669, 'Baradero', 119, 0),
(670, 'Barker', 119, 0),
(671, 'Batán', 119, 0),
(672, 'Bayauca', 119, 0),
(673, 'Benito Juarez', 119, 0),
(674, 'Berisso', 119, 0),
(675, 'Beruti', 119, 0),
(676, 'Blaquier', 119, 0),
(677, 'Bragado', 119, 0),
(678, 'Cabildo', 119, 0),
(679, 'Cacharí', 119, 0),
(680, 'Cacique', 119, 0),
(681, 'Camet', 119, 0),
(682, 'Campana', 119, 0),
(683, 'Capadmalal', 119, 0),
(684, 'Capilla del Señor', 119, 0),
(685, 'Capitán Sarmiento', 119, 0),
(686, 'Carabelas', 119, 0),
(687, 'Carhué', 119, 0),
(688, 'Cariló', 119, 0),
(689, 'Carlos Casares', 119, 0),
(690, 'Carlos María Naon', 119, 0),
(691, 'Carlos Tejedor', 119, 0),
(692, 'Carmen de Areco', 119, 0),
(693, 'Carmen de Patagones', 119, 0),
(694, 'Casbas', 119, 0),
(695, 'Castelli', 119, 0),
(696, 'Castilla', 119, 0),
(697, 'Chacabuco', 119, 0),
(698, 'Chascomús', 119, 0),
(699, 'Chillar', 119, 0),
(700, 'Chivilcoy', 119, 0),
(701, 'Claraz', 119, 0),
(702, 'Claromecó', 119, 0),
(703, 'Colón', 119, 0),
(704, 'Colonia Arcángel', 119, 0),
(705, 'Colonia Hinojo', 119, 0),
(706, 'Colonia San Miguel', 119, 0),
(707, 'Colonia Seré', 119, 0),
(708, 'Comandante Otamendi', 119, 0),
(709, 'Comodoro Py', 119, 0),
(710, 'Conesa', 119, 0),
(711, 'Copetonas', 119, 0),
(712, 'Coronel Brandsen', 119, 0),
(713, 'Coronel Dorrego', 119, 0),
(714, 'Coronel Granada', 119, 0),
(715, 'Coronel Martinez de Hoz', 119, 0),
(716, 'Coronel Pringles', 119, 0),
(717, 'Coronel Suárez', 119, 0),
(718, 'Coronel Vidal', 119, 0),
(719, 'Daireaux', 119, 0),
(720, 'Darragueira', 119, 0),
(721, 'De La Garma', 119, 0),
(722, 'Del Carril', 119, 0),
(723, 'Del Valle', 119, 0),
(724, 'Dolores', 119, 0),
(725, 'Dudignac', 119, 0),
(726, 'Duggan', 119, 0),
(727, 'El Socorro', 119, 0),
(728, 'Emilio V. Bunge', 119, 0),
(729, 'Ensenada', 119, 0),
(730, 'Espartillar', 119, 0),
(731, 'Exaltación De La Cruz', 119, 0),
(732, 'Ferré', 119, 0),
(733, 'Fortín Olavarria', 119, 0),
(734, 'Gahan', 119, 0),
(735, 'Garmania', 119, 0),
(736, 'Garré', 119, 0),
(737, 'General Alvear', 119, 0),
(738, 'General Arenales', 119, 0),
(739, 'General Belgrano', 119, 0),
(740, 'General Conesa', 119, 0),
(741, 'General Daniel Cerri', 119, 0),
(742, 'General Gelly', 119, 0),
(743, 'General Guido', 119, 0),
(744, 'General Juan Madariaga', 119, 0),
(745, 'General Lamadrid', 119, 0),
(746, 'General Las Heras', 119, 0),
(747, 'General Lavalle', 119, 0),
(748, 'General Mansilla', 119, 0),
(749, 'General O`Brien', 119, 0),
(750, 'General Pinto', 119, 0),
(751, 'General Pirán', 119, 0),
(752, 'General Rojo', 119, 0),
(753, 'General Viamonte', 119, 0),
(754, 'General Villegas', 119, 0),
(755, 'Gobernador Ugarte', 119, 0),
(756, 'González Moreno', 119, 0),
(757, 'Goyena', 119, 0),
(758, 'Gral. Las Heras', 119, 0),
(759, 'Guamirí', 119, 0),
(760, 'Guerrico', 119, 0),
(761, 'Guisasola', 119, 0),
(762, 'Henderson', 119, 0),
(763, 'Hilario Ascasubi', 119, 0),
(764, 'Hinojo', 119, 0),
(765, 'Huanguelén', 119, 0),
(766, 'Indio Rico', 119, 0),
(767, 'Inés Indart', 119, 0),
(768, 'Jáuregui', 119, 0),
(769, 'Jeppener', 119, 0),
(770, 'Juan Bautista Alberdi', 119, 0),
(771, 'Juan José Paso', 119, 0),
(772, 'Juan N. Fernandez', 119, 0),
(773, 'Junín', 119, 0),
(774, 'La Emilia', 119, 0),
(775, 'La Lucila del Mar', 119, 0),
(776, 'La Niña', 119, 0),
(777, 'Laguna Alsina', 119, 0),
(778, 'Laprida', 119, 0),
(779, 'Las Flores', 119, 0),
(780, 'Las Marianas', 119, 0),
(781, 'Las Toninas', 119, 0),
(782, 'Leandro N. Alem', 119, 0),
(783, 'Lima', 119, 0),
(784, 'Lincoln ', 119, 0),
(785, 'Lobería', 119, 0),
(786, 'Lobos', 119, 0),
(787, 'Los Cardales', 119, 0),
(788, 'Luján', 119, 0),
(789, 'Magdalena', 119, 0),
(790, 'Maipú', 119, 0),
(791, 'Manuel J. Cobo', 119, 0),
(792, 'Mar De Ajó', 119, 0),
(793, 'Mar Del Sur', 119, 0),
(794, 'Mar Del Tuyú', 119, 0),
(795, 'María Ignacia', 119, 0),
(796, 'Mariano H. Alfonzo', 119, 0),
(797, 'Máximo Paz', 119, 0),
(798, 'Mayor Buratovich', 119, 0),
(799, 'Maza', 119, 0),
(800, 'Mechita', 119, 0),
(801, 'Mechongué', 119, 0),
(802, 'Médanos', 119, 0),
(803, 'Mercedes', 119, 0),
(804, 'Micaela Cascallares', 119, 0),
(805, 'Miramar', 119, 0),
(806, 'Moll', 119, 0),
(807, 'Monez Cazón', 119, 0),
(808, 'Moquehuá', 119, 0),
(809, 'Morse', 119, 0),
(810, 'N. Olivera', 119, 0),
(811, 'Navarro', 119, 0),
(812, 'Necochea', 119, 0),
(813, 'Norberto de la Riestra', 119, 0),
(814, 'OHiggins', 119, 0),
(815, 'Olavarría', 119, 0),
(816, 'Olivera', 119, 0),
(817, 'Open Door', 119, 0),
(818, 'Orense', 119, 0),
(819, 'Oriente', 119, 0),
(820, 'Ostende', 119, 0),
(821, 'Pasteur', 119, 0),
(822, 'Patricios', 119, 0),
(823, 'Pedernales', 119, 0),
(824, 'Pedro Luro', 119, 0),
(825, 'Pehuajó', 119, 0),
(826, 'Pellegrini', 119, 0),
(827, 'Pérez Millán', 119, 0),
(828, 'Pergamino', 119, 0),
(829, 'Pila', 119, 0),
(830, 'Pirovano', 119, 0),
(831, 'Puán', 119, 0),
(832, 'Pueblo San José', 119, 0),
(833, 'Pueblo Santa María', 119, 0),
(834, 'Pueblo Santa Trinidad', 119, 0),
(835, 'Punta Alta', 119, 0),
(836, 'Punta Lara', 119, 0),
(837, 'Quenumá', 119, 0),
(838, 'Quequén', 119, 0),
(839, 'Quiroga', 119, 0),
(840, 'Rafael Obligado', 119, 0),
(841, 'Ramallo', 119, 0),
(842, 'Ramón Santamarina', 119, 0),
(843, 'Rancagua', 119, 0),
(844, 'Ranchos', 119, 0),
(845, 'Rauch', 119, 0),
(846, 'Rawson', 119, 0),
(847, 'Río Tala', 119, 0),
(848, 'Rivadavia', 119, 0),
(849, 'Rivera', 119, 0),
(850, 'Roberts', 119, 0),
(851, 'Rojas', 119, 0),
(852, 'Roque Pérez', 119, 0),
(853, 'Saavedra', 119, 0),
(854, 'Saladillo', 119, 0),
(855, 'Salazar', 119, 0),
(856, 'Saldungaray', 119, 0),
(857, 'Salliqueló', 119, 0),
(858, 'Salto', 119, 0),
(859, 'Salvador María', 119, 0),
(860, 'San Agustín', 119, 0),
(861, 'San Andrés de Giles', 119, 0),
(862, 'San Antonio De Areco', 119, 0),
(863, 'San Bernardo Del Tuyú', 119, 0),
(864, 'San Carlos de Bolivar', 119, 0),
(865, 'San Cayetano', 119, 0),
(866, 'San Clemente Del Tuyú', 119, 0),
(867, 'San Francisco de Bellocq', 119, 0),
(868, 'San Manuel', 119, 0),
(869, 'San Miguel del Monte', 119, 0),
(870, 'San Nicolás de los Arroyos', 119, 0),
(871, 'San Pedro', 119, 0),
(872, 'San Vicente', 119, 0),
(873, 'Santa Clara del Mar', 119, 0),
(874, 'Santa Lucía', 119, 0),
(875, 'Santa Regina', 119, 0),
(876, 'Santa Teresita', 119, 0),
(877, 'Sas. Bayas', 119, 0),
(878, 'Sierra Chica', 119, 0),
(879, 'Sierra de la Ventana', 119, 0),
(880, 'Solés', 119, 0),
(881, 'Stroeder', 119, 0),
(882, 'Suipacha', 119, 0),
(883, 'Tandil', 119, 0),
(884, 'Tapalqué', 119, 0),
(885, 'Timonte', 119, 0),
(886, 'Todd', 119, 0),
(887, 'Tornquist', 119, 0),
(888, 'Torres', 119, 0),
(889, 'Trenque Lauquen', 119, 0),
(890, 'Tres Arroyos', 119, 0),
(891, 'Tres Lomas', 119, 0),
(892, 'Urdampilleta', 119, 0),
(893, 'Uribelarrea', 119, 0),
(894, 'Urquiza', 119, 0),
(895, 'Valeria del Mar', 119, 0),
(896, 'Vedia', 119, 0),
(897, 'Verónica', 119, 0),
(898, 'Vicente Casares', 119, 0),
(899, 'Villa Arcadia', 119, 0),
(900, 'Villa Estación Ramallo', 119, 0),
(901, 'Villa Fortabat', 119, 0),
(902, 'Villa Gesell', 119, 0),
(903, 'Villa Iris', 119, 0),
(904, 'Villa Lía', 119, 0),
(905, 'Villa Mónica', 119, 0),
(906, 'Villa Ortiz', 119, 0),
(907, 'Villa Sauze', 119, 0),
(908, 'Villalonga', 119, 0),
(909, 'Villanueva', 119, 0),
(910, 'Vivoretá', 119, 0),
(911, 'Zárate', 119, 0),
(912, 'Alijilán', 121, 0),
(913, 'Ambato', 121, 0),
(914, 'Ancasti', 121, 0),
(915, 'Andalgala', 121, 0),
(916, 'Antofagasta', 121, 0),
(917, 'Bañado de Ovanta', 121, 0),
(918, 'Belen', 121, 0),
(919, 'Capayan', 121, 0),
(920, 'Catamarca', 121, 0),
(921, 'Chañar Punco', 121, 0),
(922, 'Chumbicha', 121, 0),
(923, 'Colonia Nueva Coneta', 121, 0),
(924, 'Colpes', 121, 0),
(925, 'Coneta', 121, 0),
(926, 'Copacabana', 121, 0),
(927, 'Corral Quemado', 121, 0),
(928, 'El Alto', 121, 0),
(929, 'El Rodeo', 121, 0),
(930, 'Esquiú', 121, 0),
(931, 'F.M.Esquiu', 121, 0),
(932, 'Famatanca', 121, 0),
(933, 'Farallón Negro', 121, 0),
(934, 'Fiambalá', 121, 0),
(935, 'Hualfín', 121, 0),
(936, 'Huillampina', 121, 0),
(937, 'Icaño', 121, 0),
(938, 'La Guardia', 121, 0),
(939, 'La Merced', 121, 0),
(940, 'La Paz', 121, 0),
(941, 'La Puerta', 121, 0),
(942, 'Londres', 121, 0),
(943, 'Loro Huasi', 121, 0),
(944, 'Los Altos', 121, 0),
(945, 'Medanitos', 121, 0),
(946, 'Miraflores', 121, 0),
(947, 'Mutquin', 121, 0),
(948, 'Paclin', 121, 0),
(949, 'Palo Blanco', 121, 0),
(950, 'Poman', 121, 0),
(951, 'Quirós', 121, 0),
(952, 'Recreo', 121, 0),
(953, 'Rincón', 121, 0),
(954, 'San Fernando del V. de Catamarca', 121, 0),
(955, 'San Isidro', 121, 0),
(956, 'San José', 121, 0),
(957, 'Santa Maria', 121, 0),
(958, 'Santa Rosa', 121, 0),
(959, 'Saujil', 121, 0),
(960, 'Siján', 121, 0),
(961, 'Tinogasta', 121, 0),
(962, 'Valle Viejo', 121, 0),
(963, 'Villa Dolores', 121, 0),
(964, 'Villa El Alto', 121, 0),
(965, '1 de Mayo', 122, 0),
(966, '12 de Octubre', 122, 0),
(967, '25 de Mayo', 122, 0),
(968, '9 de Julio', 122, 0),
(969, 'Almirante Brown', 122, 0),
(970, 'Avia Terai', 122, 0),
(971, 'Barranqueras', 122, 0),
(972, 'Basail', 122, 0),
(973, 'Bermejo', 122, 0),
(974, 'Campo Largo', 122, 0),
(975, 'Capitán Solari', 122, 0),
(976, 'Chacabuco', 122, 0),
(977, 'Charadai', 122, 0),
(978, 'Charata', 122, 0),
(979, 'Ciervo Petiso', 122, 0),
(980, 'Colonia Aborígen Chaco', 122, 0),
(981, 'Colonia Benítez', 122, 0),
(982, 'Colonia Elisa', 122, 0),
(983, 'Colonia Unidas. C. del Bermejo', 122, 0),
(984, 'Comandante Fernandez', 122, 0),
(985, 'Coronel Du Graty', 122, 0),
(986, 'Corzuela', 122, 0),
(987, 'Cote Lai', 122, 0),
(988, 'El Sauzalito', 122, 0),
(989, 'F.Sta Maria de Oro', 122, 0),
(990, 'Fontana', 122, 0),
(991, 'Gancedo', 122, 0),
(992, 'General Belgrano', 122, 0),
(993, 'General Donovan', 122, 0),
(994, 'General Guemes', 122, 0),
(995, 'Gral. José de San Martín', 122, 0),
(996, 'Gral. Pinedo', 122, 0),
(997, 'Gral. Vedia', 122, 0),
(998, 'Hermoso Campo', 122, 0),
(999, 'Independencia', 122, 0),
(1000, 'Juan José Castelli', 122, 0),
(1001, 'La Clotilde', 122, 0),
(1002, 'La Escondida', 122, 0),
(1003, 'La Leonesa', 122, 0),
(1004, 'La Tigra', 122, 0),
(1005, 'La Verde', 122, 0),
(1006, 'Laguna Limpia', 122, 0),
(1007, 'Lapachito', 122, 0),
(1008, 'Las Breñas', 122, 0),
(1009, 'Las Garcitas', 122, 0),
(1010, 'Ldor Gral San Martin', 122, 0),
(1011, 'Libertad', 122, 0),
(1012, 'Los Frentones', 122, 0),
(1013, 'Machagai', 122, 0),
(1014, 'Maipu', 122, 0),
(1015, 'Makellé', 122, 0),
(1016, 'Margarita Belén', 122, 0),
(1017, 'Mayor Luis Fontana', 122, 0),
(1018, 'Napenay', 122, 0),
(1019, 'Nueva Pompeya', 122, 0),
(1020, 'O Higgins', 122, 0),
(1021, 'Pampa Almirón', 122, 0),
(1022, 'Pampa del Indio', 122, 0),
(1023, 'Pampa del Infierno', 122, 0),
(1024, 'Pres. de la Plaza', 122, 0),
(1025, 'Presidencia R. Sáenz Peña', 122, 0),
(1026, 'Presidencia Roca', 122, 0),
(1027, 'Pt. Bermejo', 122, 0),
(1028, 'Pt. Tirol', 122, 0),
(1029, 'Quitilipi', 122, 0),
(1030, 'Samuhú', 122, 0),
(1031, 'San Bernardo', 122, 0),
(1032, 'San Fernando', 122, 0),
(1033, 'San Lorenzo', 122, 0),
(1034, 'Santa Sylvina', 122, 0),
(1035, 'Sargento Cabral', 122, 0),
(1036, 'Selvas del Río del Oro', 122, 0),
(1037, 'Taco Pozo', 122, 0),
(1038, 'Tapenaga', 122, 0),
(1039, 'Tres Isletas', 122, 0),
(1040, 'Villa Ángela', 122, 0),
(1041, 'Villa Berthet', 122, 0),
(1042, 'Villa Río Bermejito', 122, 0),
(1043, 'Alto Río Senguer', 123, 0),
(1044, 'Camarones', 123, 0),
(1045, 'Cholila', 123, 0),
(1046, 'Ciudadela', 123, 0),
(1047, 'Comodoro Rivadavia', 123, 0),
(1048, 'Corcovado', 123, 0),
(1049, 'Cushamen', 123, 0),
(1050, 'Diadema Argentina', 123, 0),
(1051, 'Dolavon', 123, 0),
(1052, 'Don Bosco', 123, 0),
(1053, 'El Maitén', 123, 0),
(1054, 'Escalante', 123, 0),
(1055, 'Esquel', 123, 0),
(1056, 'Florentino Ameghino', 123, 0),
(1057, 'Futaleufu', 123, 0),
(1058, 'Gaiman', 123, 0),
(1059, 'Gastre', 123, 0),
(1060, 'General Mosconi', 123, 0),
(1061, 'Gobernador Costa', 123, 0),
(1062, 'Gualjaina', 123, 0),
(1063, 'Hoyo de Epuyén', 123, 0),
(1064, 'José de San Martín', 123, 0),
(1065, 'Lago Puelo', 123, 0),
(1066, 'Languiñeo', 123, 0),
(1067, 'Las Plumas', 123, 0),
(1068, 'Leleque', 123, 0),
(1069, 'Martires', 123, 0),
(1070, 'Paso de Indios', 123, 0),
(1071, 'Playa Unión', 123, 0),
(1072, 'Puerto Madryn', 123, 0),
(1073, 'Rada Tilly', 123, 0),
(1074, 'Rawson', 123, 0),
(1075, 'Río Mayo', 123, 0),
(1076, 'Río Pico', 123, 0),
(1077, 'Rio Senguer', 123, 0),
(1078, 'Sarmiento', 123, 0),
(1079, 'Tecka', 123, 0),
(1080, 'Tehuelches', 123, 0),
(1081, 'Telsen', 123, 0),
(1082, 'Trelew', 123, 0),
(1083, 'Trevellin', 123, 0),
(1084, 'Adelia María', 124, 0),
(1085, 'Alcira', 124, 0),
(1086, 'Alejandro Roca', 124, 0),
(1087, 'Alejo Ledesma', 124, 0),
(1088, 'Alicia', 124, 0),
(1089, 'Almafuerte', 124, 0),
(1090, 'Alta Gracia', 124, 0),
(1091, 'Alto Alegre', 124, 0),
(1092, 'Altos de Chipión', 124, 0),
(1093, 'Arias', 124, 0),
(1094, 'Arroyito', 124, 0),
(1095, 'Arroyo Cabral', 124, 0),
(1096, 'Ausonia', 124, 0),
(1097, 'Ballesteros', 124, 0),
(1098, 'Balnearia', 124, 0),
(1099, 'Benjamín Gould', 124, 0),
(1100, 'Berrotarán', 124, 0),
(1101, 'Bialet Massé', 124, 0),
(1102, 'Brinkmann', 124, 0),
(1103, 'Bulnes', 124, 0),
(1104, 'Calamuchita', 124, 0),
(1105, 'Calchín', 124, 0),
(1106, 'Camilo Aldao', 124, 0),
(1107, 'Cañada de Luque', 124, 0),
(1108, 'Canals', 124, 0),
(1109, 'Capilla del Monte', 124, 0),
(1110, 'Carnerillo', 124, 0),
(1111, 'Carrilobo', 124, 0),
(1112, 'Cavanagh', 124, 0),
(1113, 'Charras', 124, 0),
(1114, 'Chazón', 124, 0),
(1115, 'Cintra', 124, 0),
(1116, 'Colazo', 124, 0),
(1117, 'Colon', 124, 0),
(1118, 'Colonia Caroya', 124, 0),
(1119, 'Colonia Marina', 124, 0),
(1120, 'Colonia San Bartolomé', 124, 0),
(1121, 'Colonia Vignaud', 124, 0),
(1122, 'Coronel Baigorria', 124, 0),
(1123, 'Coronel Moldes', 124, 0),
(1124, 'Corral de Bustos', 124, 0),
(1125, 'Corralito', 124, 0),
(1126, 'Cosquín', 124, 0),
(1127, 'Costa Sacate', 124, 0),
(1128, 'Cruz Del Eje', 124, 0),
(1129, 'Dalmacio Vélez Sarsfield', 124, 0),
(1130, 'Deán Funes', 124, 0),
(1131, 'Del Campillo', 124, 0),
(1132, 'Despeñaderos', 124, 0),
(1133, 'Devoto', 124, 0),
(1134, 'El Arañado', 124, 0),
(1135, 'El Fortín', 124, 0),
(1136, 'El Tío', 124, 0),
(1137, 'Elena', 124, 0),
(1138, 'Embalse', 124, 0),
(1139, 'Etruria', 124, 0),
(1140, 'Freyre', 124, 0),
(1141, 'General Baldissera', 124, 0),
(1142, 'General Cabrera', 124, 0),
(1143, 'General Deheza', 124, 0),
(1144, 'General Lavalle', 124, 0),
(1145, 'General Paz', 124, 0),
(1146, 'General Roca', 124, 0),
(1147, 'General San Martin', 124, 0),
(1148, 'Guatimozín', 124, 0),
(1149, 'Hernando', 124, 0),
(1150, 'Hipólito Bouchard', 124, 0),
(1151, 'Huanchilla', 124, 0),
(1152, 'Huinca Renancó', 124, 0),
(1153, 'Idiazábal', 124, 0),
(1154, 'Inriville', 124, 0),
(1155, 'Ischilin', 124, 0),
(1156, 'Isla Verde', 124, 0),
(1157, 'James Craik', 124, 0),
(1158, 'Jesús María', 124, 0),
(1159, 'Juarez Celman', 124, 0),
(1160, 'Justiniano Posse', 124, 0),
(1161, 'La Calera', 124, 0),
(1162, 'La Carlota', 124, 0),
(1163, 'La Cautiva', 124, 0),
(1164, 'La Cesira', 124, 0),
(1165, 'La Cruz', 124, 0),
(1166, 'La Cumbre', 124, 0),
(1167, 'La Falda', 124, 0),
(1168, 'La Francia', 124, 0),
(1169, 'La Granja', 124, 0),
(1170, 'La Laguna', 124, 0),
(1171, 'La Paquita', 124, 0),
(1172, 'La Para', 124, 0),
(1173, 'La Paz', 124, 0),
(1174, 'La Playosa', 124, 0),
(1175, 'La Puerta ', 124, 0),
(1176, 'La Tordilla', 124, 0),
(1177, 'Laborde', 124, 0),
(1178, 'Laboulaye', 124, 0),
(1179, 'Laguna Larga', 124, 0),
(1180, 'Las Acequias', 124, 0),
(1181, 'Las Arrias', 124, 0),
(1182, 'Las Higueras', 124, 0),
(1183, 'Las Junturas', 124, 0),
(1184, 'Las Peñas', 124, 0),
(1185, 'Las Perdices', 124, 0),
(1186, 'Las Varas', 124, 0),
(1187, 'Las Varillas', 124, 0),
(1188, 'Las Vertientes', 124, 0),
(1189, 'Leones', 124, 0),
(1190, 'Los Cerrillos', 124, 0),
(1191, 'Los Cocos', 124, 0),
(1192, 'Los Cóndores', 124, 0),
(1193, 'Los Surgentes', 124, 0),
(1194, 'Lozada', 124, 0),
(1195, 'Lucio V. Mansilla', 124, 0),
(1196, 'Luque', 124, 0),
(1197, 'Luyaba', 124, 0),
(1198, 'Malagueño', 124, 0),
(1199, 'Manfredi', 124, 0),
(1200, 'Marcos Juarez', 124, 0),
(1201, 'Marull', 124, 0),
(1202, 'Matorrales', 124, 0),
(1203, 'Mattaldi', 124, 0),
(1204, 'Melo', 124, 0),
(1205, 'Mina Clavero', 124, 0),
(1206, 'Minas', 124, 0),
(1207, 'Miramar', 124, 0),
(1208, 'Monte Buey', 124, 0),
(1209, 'Monte Maíz', 124, 0),
(1210, 'Montecristo', 124, 0),
(1211, 'Morrison', 124, 0),
(1212, 'Morteros', 124, 0),
(1213, 'Noetinger', 124, 0),
(1214, 'Nono', 124, 0),
(1215, 'Obispo Trejo', 124, 0),
(1216, 'Oliva', 124, 0),
(1217, 'Oncativo', 124, 0),
(1218, 'Ordoñez', 124, 0),
(1219, 'Pampayasta Sur', 124, 0),
(1220, 'Pascanas', 124, 0),
(1221, 'Pasco', 124, 0),
(1222, 'Pilar', 124, 0),
(1223, 'Piquillín', 124, 0),
(1224, 'Pocho', 124, 0),
(1225, 'Porteña', 124, 0),
(1226, 'Pozo del Molle', 124, 0),
(1227, 'Pte Roque Saenz Peña', 124, 0),
(1228, 'Pueblo Italiano', 124, 0),
(1229, 'Punilla', 124, 0),
(1230, 'Quilino', 124, 0),
(1231, 'Río Ceballos', 124, 0),
(1232, 'Río de los Sauces', 124, 0),
(1233, 'Rio Primero', 124, 0),
(1234, 'Rio Seco', 124, 0),
(1235, 'Rio Segundo', 124, 0),
(1236, 'Río Tercero', 124, 0),
(1237, 'S. Temple', 124, 0),
(1238, 'Sacanta', 124, 0),
(1239, 'Saira', 124, 0),
(1240, 'Salsacate', 124, 0),
(1241, 'Salsipuedes', 124, 0),
(1242, 'Sampacho', 124, 0),
(1243, 'San Agustín', 124, 0),
(1244, 'San Alberto', 124, 0),
(1245, 'San Antonio de Arredondo', 124, 0),
(1246, 'San Antonio de Litín', 124, 0),
(1247, 'San Basilio', 124, 0),
(1248, 'San Carlos Minas', 124, 0),
(1249, 'San Esteban', 124, 0),
(1250, 'San Francisco', 124, 0),
(1251, 'San Javier', 124, 0),
(1252, 'San José', 124, 0),
(1253, 'San José de la Dormida', 124, 0),
(1254, 'San Justo', 124, 0),
(1255, 'San Pedro', 124, 0),
(1256, 'Santa Catalina', 124, 0),
(1257, 'Santa Eufemia', 124, 0),
(1258, 'Santa Rosa', 124, 0),
(1259, 'Santa Rosa de Calamuchita', 124, 0),
(1260, 'Santa Rosa del Río Primero', 124, 0),
(1261, 'Sarmiento', 124, 0),
(1262, 'Saturnino María Laspiur', 124, 0),
(1263, 'Sebastián Elcano', 124, 0),
(1264, 'Serrano', 124, 0),
(1265, 'Serrezuela', 124, 0),
(1266, 'Sobremonte', 124, 0),
(1267, 'Tancacha', 124, 0),
(1268, 'Tanti', 124, 0),
(1269, 'Tercero Arriba', 124, 0),
(1270, 'Ticino', 124, 0),
(1271, 'Tío Pujio', 124, 0),
(1272, 'Toledo', 124, 0),
(1273, 'Tortoral', 124, 0),
(1274, 'Tránsito', 124, 0),
(1275, 'Tuclame', 124, 0),
(1276, 'Tulumba', 124, 0),
(1277, 'Ucacha', 124, 0),
(1278, 'Union', 124, 0),
(1279, 'Unquillo', 124, 0),
(1280, 'Valle Hermoso', 124, 0),
(1281, 'Viamonte', 124, 0),
(1282, 'Vicuña Mackenna', 124, 0),
(1283, 'Villa Allende', 124, 0),
(1284, 'Villa Ascasubi', 124, 0),
(1285, 'Villa Carlos Paz', 124, 0),
(1286, 'Villa Concepción del Tío', 124, 0),
(1287, 'Villa Cura Brochero', 124, 0),
(1288, 'Villa de María', 124, 0),
(1289, 'Villa de Soto', 124, 0),
(1290, 'Villa del Dique', 124, 0),
(1291, 'Villa del Rosario', 124, 0),
(1292, 'Villa del Totoral', 124, 0),
(1293, 'Villa Dolores', 124, 0),
(1294, 'Villa Fontana', 124, 0),
(1295, 'Villa General Belgrano', 124, 0),
(1296, 'Villa Giardino', 124, 0),
(1297, 'Villa Gral. Belgrano', 124, 0),
(1298, 'Villa Huidobro', 124, 0),
(1299, 'Villa Maria', 124, 0),
(1300, 'Villa Nueva', 124, 0),
(1301, 'Villa Reducción', 124, 0),
(1302, 'Villa Rumipal', 124, 0),
(1303, 'Villa Tulumba', 124, 0),
(1304, 'Villa Valeria', 124, 0),
(1305, 'Washington', 124, 0),
(1306, 'Wenceslao Escalante', 124, 0),
(1307, 'Yacanto', 124, 0),
(1308, '9 de Julio', 125, 0),
(1309, 'Alvear', 125, 0),
(1310, 'Bella Vista', 125, 0),
(1311, 'Beron de Astrada', 125, 0),
(1312, 'Chavarría', 125, 0),
(1313, 'Colonia Carlos Pellegrini', 125, 0),
(1314, 'Colonia Liebig´s', 125, 0),
(1315, 'Concepcion', 125, 0),
(1316, 'Corrientes', 125, 0),
(1317, 'Curuzu Cuatia', 125, 0),
(1318, 'El Sombrero', 125, 0),
(1319, 'Empedrado', 125, 0),
(1320, 'Esquina', 125, 0),
(1321, 'Felipe Yofré', 125, 0),
(1322, 'Garruchos', 125, 0),
(1323, 'General Alvear', 125, 0),
(1324, 'General Paz', 125, 0),
(1325, 'Gobernador Ing. Valentín', 125, 0),
(1326, 'Gobernador Juan E. Martinez', 125, 0),
(1327, 'Goya', 125, 0),
(1328, 'Guaviravi', 125, 0),
(1329, 'Itati', 125, 0),
(1330, 'Ituzaingo', 125, 0),
(1331, 'La Cruz', 125, 0),
(1332, 'Laguna Brava', 125, 0),
(1333, 'Lavalle', 125, 0),
(1334, 'Libertador', 125, 0),
(1335, 'Loreto', 125, 0),
(1336, 'Mariano I. Loza', 125, 0),
(1337, 'Mburucuya', 125, 0),
(1338, 'Mercedes', 125, 0),
(1339, 'Mocoretá', 125, 0),
(1340, 'Monte Caseros', 125, 0),
(1341, 'Ntra. Señora del Rosario de Caa Catí', 125, 0),
(1342, 'Paso de la Patria', 125, 0),
(1343, 'Paso de los Libres', 125, 0),
(1344, 'Pedro R. Fernandez', 125, 0),
(1345, 'Perugorria', 125, 0),
(1346, 'Saladas', 125, 0),
(1347, 'San Carlos', 125, 0),
(1348, 'San Cosme', 125, 0),
(1349, 'San Lorenzo', 125, 0),
(1350, 'San Luis del Palmar', 125, 0),
(1351, 'San Martin', 125, 0),
(1352, 'San Miguel', 125, 0),
(1353, 'San Roque', 125, 0),
(1354, 'Santa Ana', 125, 0),
(1355, 'Santa Lucía', 125, 0),
(1356, 'Santa Rosa', 125, 0),
(1357, 'Santo Tome', 125, 0),
(1358, 'Sauce', 125, 0),
(1359, 'Virasoro', 125, 0),
(1360, 'Yapeyú', 125, 0),
(1361, 'Aldea Brasilera', 126, 0),
(1362, 'Aldea San Antonio', 126, 0),
(1363, 'Aldea Valle María', 126, 0),
(1364, 'Aranguren', 126, 0),
(1365, 'Basalvilbaso', 126, 0),
(1366, 'Bovril', 126, 0),
(1367, 'Calabacilla', 126, 0),
(1368, 'Caseros', 126, 0),
(1369, 'Cerrito', 126, 0),
(1370, 'Chajarí', 126, 0),
(1371, 'Colón', 126, 0),
(1372, 'Concep. Del Uruguay', 126, 0),
(1373, 'Concordia', 126, 0),
(1374, 'Conscripto Bernardi', 126, 0),
(1375, 'Costa del Uruguay', 126, 0),
(1376, 'Crespo', 126, 0),
(1377, 'Diamante', 126, 0),
(1378, 'Domínguez', 126, 0),
(1379, 'El Brillante', 126, 0),
(1380, 'El Pingo', 126, 0),
(1381, 'Enrique Carbó', 126, 0),
(1382, 'Federacion', 126, 0),
(1383, 'Federal', 126, 0),
(1384, 'Feliciano', 126, 0),
(1385, 'General Campos', 126, 0),
(1386, 'General Galarza', 126, 0),
(1387, 'Gilbert', 126, 0),
(1388, 'Gobernador Mansilla', 126, 0),
(1389, 'Gualeguay', 126, 0),
(1390, 'Gualeguaychú', 126, 0),
(1391, 'Hasenkamp', 126, 0),
(1392, 'Hernandarias', 126, 0),
(1393, 'Hernández', 126, 0),
(1394, 'Ibicuy', 126, 0),
(1395, 'Jubileo', 126, 0),
(1396, 'La Criolla', 126, 0),
(1397, 'La Paz', 126, 0),
(1398, 'Larroque', 126, 0),
(1399, 'Libertador San Martín', 126, 0),
(1400, 'Los Charrúas', 126, 0),
(1401, 'Los Conquistadores', 126, 0),
(1402, 'Lucas Ganzáles', 126, 0),
(1403, 'Macía', 126, 0),
(1404, 'María Grande', 126, 0),
(1405, 'Nogoya', 126, 0),
(1406, 'Oro Verde', 126, 0),
(1407, 'Osvaldo Magnasco', 126, 0),
(1408, 'Parana', 126, 0),
(1409, 'Piedras Blancas', 126, 0),
(1410, 'Pronunciamiento', 126, 0),
(1411, 'Pt. Yeruá', 126, 0),
(1412, 'Pueblo Arrúa', 126, 0),
(1413, 'Pueblo Brugo', 126, 0),
(1414, 'Pueblo Cazés', 126, 0),
(1415, 'Rosario del Tala', 126, 0),
(1416, 'San Benito', 126, 0),
(1417, 'San Gustavo', 126, 0),
(1418, 'San Jaime de la Frontera', 126, 0),
(1419, 'San José', 126, 0),
(1420, 'San José de Feliciano', 126, 0),
(1421, 'San Martin', 126, 0),
(1422, 'San Salvador', 126, 0),
(1423, 'Santa Ana', 126, 0),
(1424, 'Santa Anita', 126, 0),
(1425, 'Santa Elena', 126, 0),
(1426, 'Sauce de Luna', 126, 0),
(1427, 'Seguí', 126, 0),
(1428, 'Strobel', 126, 0),
(1429, 'Tabossi', 126, 0),
(1430, 'Tala', 126, 0),
(1431, 'Ubajay', 126, 0),
(1432, 'Urdinarrain', 126, 0),
(1433, 'Uruguay', 126, 0),
(1434, 'Victoria', 126, 0),
(1435, 'Villa Clara', 126, 0),
(1436, 'Villa Paranacito', 126, 0),
(1437, 'Villa Urquiza', 126, 0),
(1438, 'Villaguay', 126, 0),
(1439, 'Bermejo', 127, 0),
(1440, 'Buena Vista', 127, 0),
(1441, 'Clorinda', 127, 0),
(1442, 'Colonia Pastoril', 127, 0),
(1443, 'Comandante Fontana', 127, 0),
(1444, 'El Colorado', 127, 0),
(1445, 'Espinillo', 127, 0),
(1446, 'Estanislao del Campo', 127, 0),
(1447, 'Fn. Cabo 1º Lugones', 127, 0),
(1448, 'Ciudad de Formosa', 127, 0),
(1449, 'Gral. Lucio Victorio Mansilla', 127, 0),
(1450, 'Gral. Mosconi', 127, 0),
(1451, 'Gran Guardia', 127, 0),
(1452, 'Herradura', 127, 0),
(1453, 'Ibarreta', 127, 0),
(1454, 'Ing. Guillermo N. Juárez', 127, 0),
(1455, 'Laguna Blanca', 127, 0),
(1456, 'Laguna Yema', 127, 0),
(1457, 'Laishi', 127, 0),
(1458, 'Las Lomitas', 127, 0),
(1459, 'Los Chiriguanos', 127, 0),
(1460, 'Matacos', 127, 0),
(1461, 'Mayor Villafañe', 127, 0),
(1462, 'Misión Tacaaglé', 127, 0),
(1463, 'Palo Santo', 127, 0),
(1464, 'Patiño', 127, 0),
(1465, 'Pilagas', 127, 0),
(1466, 'Pilcomayo', 127, 0),
(1467, 'Pirane', 127, 0),
(1468, 'Pozo del Tigre', 127, 0),
(1469, 'Ramon Lista', 127, 0),
(1470, 'Riacho He-He', 127, 0),
(1471, 'San Francisco de Laishi', 127, 0),
(1472, 'San Martín II', 127, 0),
(1473, 'Tres Lagunas', 127, 0),
(1474, 'Villa Dos Trece', 127, 0),
(1475, 'Villa Escolar', 127, 0),
(1476, 'Villa General Guemes', 127, 0),
(1477, 'Villa General Manuel Belgrano', 127, 0),
(1478, 'Abra Pampa', 128, 0),
(1479, 'Barrio Negro', 128, 0),
(1480, 'Caimancito', 128, 0),
(1481, 'Calilegua', 128, 0),
(1482, 'Chalicán', 128, 0),
(1483, 'Cochinoca', 128, 0),
(1484, 'Dr. Manuel Belgrano', 128, 0),
(1485, 'El Aguilar', 128, 0),
(1486, 'El Carmen', 128, 0),
(1487, 'El Piquete', 128, 0),
(1488, 'El Talar', 128, 0),
(1489, 'Fraile Pintado', 128, 0),
(1490, 'Humahuaca', 128, 0),
(1491, 'La Mendieta', 128, 0),
(1492, 'La Quiaca', 128, 0),
(1493, 'Ledesma', 128, 0),
(1494, 'Libertador Gral. San Martín', 128, 0),
(1495, 'Los Lapachos', 128, 0),
(1496, 'Lozano', 128, 0),
(1497, 'Maimará', 128, 0),
(1498, 'Mina Pirquitas', 128, 0),
(1499, 'Monterrico', 128, 0),
(1500, 'Palma Sola', 128, 0),
(1501, 'Palpala', 128, 0),
(1502, 'Pampa Blanca', 128, 0),
(1503, 'Perico', 128, 0),
(1504, 'Puesto Viejo', 128, 0),
(1505, 'Rinconada', 128, 0),
(1506, 'San Antonio', 128, 0),
(1507, 'San Pedro', 128, 0),
(1508, 'San Salvador de Jujuy', 128, 0),
(1509, 'Santa Barbara', 128, 0),
(1510, 'Santa Catalina', 128, 0),
(1511, 'Santa Clara', 128, 0),
(1512, 'Susques', 128, 0),
(1513, 'Tilcara', 128, 0),
(1514, 'Tres Cruces', 128, 0),
(1515, 'Tumbaya', 128, 0),
(1516, 'Valle Grande', 128, 0),
(1517, 'Volcán', 128, 0),
(1518, 'Yala ', 128, 0),
(1519, 'Yavi', 128, 0),
(1520, 'Yuto', 128, 0),
(1521, '25 de Mayo', 129, 0),
(1522, 'Algarrobo del Aguila', 129, 0),
(1523, 'Alpachiri', 129, 0),
(1524, 'Alta Italia', 129, 0),
(1525, 'Anguil', 129, 0),
(1526, 'Arata', 129, 0),
(1527, 'Atreuco', 129, 0),
(1528, 'Bernasconi', 129, 0),
(1529, 'Caleu Caleu', 129, 0),
(1530, 'Caleufú', 129, 0),
(1531, 'Catrilo', 129, 0),
(1532, 'Chalileo', 129, 0),
(1533, 'Chapaleufu', 129, 0),
(1534, 'Chical Co', 129, 0),
(1535, 'Colonia Barón', 129, 0),
(1536, 'Conhelo', 129, 0),
(1537, 'Cuchillo Co', 129, 0),
(1538, 'Curaco', 129, 0),
(1539, 'Doblas', 129, 0),
(1540, 'Eduardo Castex', 129, 0),
(1541, 'Embajador Martini', 129, 0),
(1542, 'General Acha', 129, 0),
(1543, 'General Manuel J. Campos', 129, 0),
(1544, 'General Pico', 129, 0),
(1545, 'General San Martín', 129, 0),
(1546, 'Guatraché', 129, 0),
(1547, 'Hucal', 129, 0),
(1548, 'Ing. Luiggi', 129, 0),
(1549, 'Intendente Alvear', 129, 0),
(1550, 'Jacinto Aráuz', 129, 0),
(1551, 'La Adela', 129, 0),
(1552, 'La Maruja', 129, 0),
(1553, 'Limay Mahuida', 129, 0),
(1554, 'Lonquimay', 129, 0),
(1555, 'Loventue', 129, 0),
(1556, 'Luan Toro', 129, 0),
(1557, 'M. Cané', 129, 0),
(1558, 'M. Riglos', 129, 0),
(1559, 'Macachín', 129, 0),
(1560, 'Maraco', 129, 0),
(1561, 'Metileo', 129, 0),
(1562, 'Monte Nievas', 129, 0),
(1563, 'Perera', 129, 0),
(1564, 'Puelches', 129, 0),
(1565, 'Puelen', 129, 0),
(1566, 'Quemu Quemu', 129, 0),
(1567, 'Rancul', 129, 0),
(1568, 'Realico', 129, 0),
(1569, 'Rolón', 129, 0),
(1570, 'Santa Isabel', 129, 0),
(1571, 'Santa Rosa', 129, 0),
(1572, 'Santa Teresa', 129, 0),
(1573, 'Telén', 129, 0),
(1574, 'Toay', 129, 0),
(1575, 'Trenel', 129, 0),
(1576, 'Uhuel Calel', 129, 0),
(1577, 'Uriburu', 129, 0),
(1578, 'Utracan', 129, 0),
(1579, 'Vértiz', 129, 0),
(1580, 'Victoria', 129, 0),
(1581, 'Villa Mirasol', 129, 0),
(1582, 'Winifreda', 129, 0),
(1583, 'Agua Blanca', 130, 0),
(1584, 'Aguayo', 130, 0),
(1585, 'Aicuña', 130, 0),
(1586, 'Aimogasta', 130, 0),
(1587, 'Alpasincha', 130, 0),
(1588, 'Amaná', 130, 0),
(1589, 'Ambil', 130, 0),
(1590, 'Aminga', 130, 0),
(1591, 'Anguinán', 130, 0),
(1592, 'Anillaco', 130, 0),
(1593, 'Arauco', 130, 0),
(1594, 'Banda Florida', 130, 0),
(1595, 'Campanas', 130, 0),
(1596, 'Castro Barros', 130, 0),
(1597, 'Cebollar', 130, 0),
(1598, 'Chamical', 130, 0),
(1599, 'Chañar', 130, 0),
(1600, 'Chepes', 130, 0),
(1601, 'Chilecito', 130, 0),
(1602, 'Chuquis', 130, 0),
(1603, 'Corral de Isaac', 130, 0),
(1604, 'Desiderio Tello', 130, 0),
(1605, 'El Carrizal', 130, 0),
(1606, 'El Potrerillo', 130, 0),
(1607, 'El Totoral', 130, 0),
(1608, 'Famatina', 130, 0),
(1609, 'Guandacol', 130, 0),
(1610, 'La Banda', 130, 0),
(1611, 'La Cuadra', 130, 0),
(1612, 'Loma Blanca', 130, 0),
(1613, 'Los Aguirres', 130, 0),
(1614, 'Los Molinos', 130, 0),
(1615, 'Los Palacios', 130, 0),
(1616, 'Los Robles', 130, 0),
(1617, 'Malanzán', 130, 0),
(1618, 'Malligasta', 130, 0),
(1619, 'Milagro', 130, 0),
(1620, 'Nonogasta', 130, 0),
(1621, 'Olta', 130, 0),
(1622, 'Pagancillo', 130, 0),
(1623, 'Patquía', 130, 0),
(1624, 'Pituil', 130, 0),
(1625, 'San Pedro', 130, 0),
(1626, 'Sañogasta', 130, 0),
(1627, 'Santa Clara', 130, 0),
(1628, 'Santa Rita de Catuna', 130, 0),
(1629, 'Santa vera Cruz', 130, 0),
(1630, 'Saolica', 130, 0),
(1631, 'Talamuyuna', 130, 0),
(1632, 'Tama', 130, 0),
(1633, 'Tilmuaqui', 130, 0),
(1634, 'Ulapes', 130, 0),
(1635, 'Vichigasta', 130, 0),
(1636, 'Villa Castelli', 130, 0),
(1637, 'Villa Mazán', 130, 0),
(1638, 'Villa San José de Vinchina', 130, 0),
(1639, 'Villa Sanagasta', 130, 0),
(1640, 'Villa Unión', 130, 0),
(1641, 'Vinchina', 130, 0),
(1642, '25 de Mayo', 131, 0),
(1643, 'Agrelo', 131, 0),
(1644, 'Alto Verde', 131, 0),
(1645, 'Bowen', 131, 0),
(1646, 'Campo Los Andes', 131, 0),
(1647, 'Carmensa', 131, 0),
(1648, 'Chacras de Coria', 131, 0),
(1649, 'Chapanay', 131, 0),
(1650, 'Chilecito', 131, 0),
(1651, 'Colonia Las Rosas', 131, 0),
(1652, 'Cordón del Plata', 131, 0),
(1653, 'Costa de Araujo', 131, 0),
(1654, 'Cuadro Bombal', 131, 0),
(1655, 'El Nihuil', 131, 0),
(1656, 'Eugenio Bustos', 131, 0),
(1657, 'Ezeiza', 131, 0),
(1658, 'General Alvear', 131, 0),
(1659, 'Godoy Cruz', 131, 0),
(1660, 'Goudge', 131, 0),
(1661, 'Gral. Alvear', 131, 0),
(1662, 'Gral. Gutiérrez', 131, 0),
(1663, 'Guaymallén', 131, 0),
(1664, 'Junin', 131, 0),
(1665, 'La Consulta', 131, 0),
(1666, 'La Dormida', 131, 0),
(1667, 'La Paz', 131, 0),
(1668, 'Las Catitas', 131, 0),
(1669, 'Las Cuevas', 131, 0),
(1670, 'Las Heras', 131, 0),
(1671, 'Las Leñas', 131, 0),
(1672, 'Las Paredes', 131, 0),
(1673, 'Lavalle', 131, 0),
(1674, 'Lujan de Cuyo', 131, 0),
(1675, 'Maipu', 131, 0),
(1676, 'Malargüe', 131, 0),
(1677, 'Medrano', 131, 0),
(1678, 'Monte Comán', 131, 0),
(1679, 'Pareditas', 131, 0),
(1680, 'Perdriel', 131, 0),
(1681, 'Rama Caída', 131, 0),
(1682, 'Real del Padre', 131, 0),
(1683, 'Rivadavia', 131, 0),
(1684, 'Rodeo del Medio', 131, 0),
(1685, 'Salto de las Rosas', 131, 0),
(1686, 'San Carlos', 131, 0),
(1687, 'San José', 131, 0),
(1688, 'San Martin', 131, 0),
(1689, 'San Rafael', 131, 0),
(1690, 'Santa Rosa', 131, 0),
(1691, 'Tres Porteñas', 131, 0),
(1692, 'Tunuyan', 131, 0),
(1693, 'Tupungato', 131, 0),
(1694, 'Ugarteche', 131, 0),
(1695, 'Uspallata', 131, 0),
(1696, 'Villa Atuel', 131, 0),
(1697, 'Villa Bastia', 131, 0),
(1698, 'Villa Nueva', 131, 0),
(1699, 'Vista Flores', 131, 0),
(1700, '25 De Mayo', 132, 0),
(1701, '9 de Julio ', 132, 0),
(1702, 'Alba Posse', 132, 0),
(1703, 'Andresito', 132, 0),
(1704, 'Apostoles', 132, 0),
(1705, 'Aristóbulo del Valle', 132, 0),
(1706, 'Azara', 132, 0),
(1707, 'Bernardo de Yrigoyen', 132, 0),
(1708, 'Bompland', 132, 0),
(1709, 'Cainguas', 132, 0),
(1710, 'Campo Grande', 132, 0),
(1711, 'Campo Ramón', 132, 0),
(1712, 'Campo Viera', 132, 0),
(1713, 'Candelaria', 132, 0),
(1714, 'Capioví', 132, 0),
(1715, 'Cerro Azul', 132, 0),
(1716, 'Concepcion', 132, 0),
(1717, 'Corpus', 132, 0),
(1718, 'Dos de Mayo', 132, 0),
(1719, 'El Alcázar', 132, 0),
(1720, 'El Dorado', 132, 0),
(1721, 'El Soberbio', 132, 0),
(1722, 'Eldorado', 132, 0),
(1723, 'Esperanza', 132, 0),
(1724, 'Est. Apóstoles', 132, 0),
(1725, 'Garuhapé', 132, 0),
(1726, 'Garupá', 132, 0),
(1727, 'Gobernador Roca', 132, 0),
(1728, 'Gral Manuel Belgrano', 132, 0),
(1729, 'Guarani', 132, 0),
(1730, 'Iguazu', 132, 0),
(1731, 'Itacaruapé', 132, 0),
(1732, 'Jardín América', 132, 0),
(1733, 'KM. 26', 132, 0),
(1734, 'Km. 8', 132, 0),
(1735, 'Laharrague', 132, 0),
(1736, 'Ldor Gral San Martin', 132, 0),
(1737, 'Leandro N. Alem', 132, 0),
(1738, 'Libertad', 132, 0),
(1739, 'Los Helechos', 132, 0),
(1740, 'María Magdalena', 132, 0),
(1741, 'Montecarlo', 132, 0),
(1742, 'Oasis', 132, 0),
(1743, 'Obera', 132, 0),
(1744, 'Panambí', 132, 0),
(1745, 'Pindapoy', 132, 0),
(1746, 'Posadas', 132, 0),
(1747, 'Puerto Iguazú', 132, 0),
(1748, 'Puerto Leoni', 132, 0),
(1749, 'Puerto Pinares', 132, 0),
(1750, 'Puerto Piray', 132, 0),
(1751, 'Puerto Rico', 132, 0),
(1752, 'Ruiz de Montoya', 132, 0),
(1753, 'Salto Encantado', 132, 0),
(1754, 'San Antonio', 132, 0),
(1755, 'San Gortardo', 132, 0),
(1756, 'San Ignacio', 132, 0),
(1757, 'San Javier', 132, 0),
(1758, 'San José', 132, 0),
(1759, 'San Martín', 132, 0),
(1760, 'San Miguel', 132, 0),
(1761, 'San Pedro', 132, 0),
(1762, 'San Vicente', 132, 0),
(1763, 'Santa Ana', 132, 0),
(1764, 'Santa Rita', 132, 0),
(1765, 'Santo Pipó', 132, 0),
(1766, 'Turumá', 132, 0),
(1767, 'Victoria', 132, 0),
(1768, 'Villa Bonita', 132, 0),
(1769, 'Wanda', 132, 0),
(1770, 'Alumine', 133, 0),
(1771, 'Andacollo', 133, 0),
(1772, 'Añelo', 133, 0),
(1773, 'Arroyito', 133, 0),
(1774, 'Buta Ranquil', 133, 0),
(1775, 'Catan Lil', 133, 0),
(1776, 'Caviahué', 133, 0),
(1777, 'Centenario', 133, 0),
(1778, 'Chos Malal', 133, 0),
(1779, 'Collon Cura', 133, 0),
(1780, 'Confluencia', 133, 0),
(1781, 'Cutral Có', 133, 0),
(1782, 'El Huecú', 133, 0),
(1783, 'Huiliches', 133, 0),
(1784, 'Junin de los Andes', 133, 0),
(1785, 'Lacar', 133, 0),
(1786, 'Las Lajas', 133, 0),
(1787, 'Las Ovejas', 133, 0),
(1788, 'Loncopue', 133, 0),
(1789, 'Los Lagos', 133, 0),
(1790, 'Mariano Moreno', 133, 0),
(1791, 'Minas', 133, 0),
(1792, 'Neuquén', 133, 0),
(1793, 'Ñorquinco', 133, 0),
(1794, 'Pehuenches', 133, 0),
(1795, 'Picun Leufu', 133, 0),
(1796, 'Picunches', 133, 0),
(1797, 'Piedra del Aguila', 133, 0),
(1798, 'Plaza Huincul', 133, 0),
(1799, 'Plottier', 133, 0),
(1800, 'Rincón de los Sauces', 133, 0),
(1801, 'San Martin de los Andes', 133, 0),
(1802, 'San Patricio del Chañar', 133, 0),
(1803, 'Senillosa', 133, 0),
(1804, 'Villa El Chocón', 133, 0),
(1805, 'Villa la Angostura', 133, 0),
(1806, 'Villa Rincón Chico', 133, 0),
(1807, 'Vista Alegre Norte', 133, 0),
(1808, 'Vista Alegre Sur', 133, 0),
(1809, 'Zapala', 133, 0),
(1810, '25 De Mayo', 135, 0),
(1811, '9 De Julio', 135, 0),
(1812, 'Adolfo Alsina', 135, 0),
(1813, 'Allen', 135, 0),
(1814, 'Avellaneda', 135, 0),
(1815, 'Barda del Medio', 135, 0),
(1816, 'Bariloche', 135, 0),
(1817, 'C.cordero', 135, 0),
(1818, 'Catriel', 135, 0),
(1819, 'Cervantes', 135, 0),
(1820, 'Chichinales', 135, 0),
(1821, 'Chimpay', 135, 0),
(1822, 'Choele Choel', 135, 0),
(1823, 'Cinco Saltos', 135, 0),
(1824, 'Cipolletti', 135, 0),
(1825, 'Comallo', 135, 0),
(1826, 'Conesa', 135, 0),
(1827, 'Coronel Balisle', 135, 0),
(1828, 'Darwin', 135, 0),
(1829, 'Dina Huapi', 135, 0),
(1830, 'El Bolsón', 135, 0),
(1831, 'El Cuy', 135, 0),
(1832, 'Ferri', 135, 0),
(1833, 'Fray Luis Beltrán', 135, 0),
(1834, 'General Conesa', 135, 0),
(1835, 'General Enrique Godoy', 135, 0),
(1836, 'General Fernández Oro', 135, 0),
(1837, 'General Roca', 135, 0),
(1838, 'Ingeniero Jacobacci', 135, 0),
(1839, 'Ingeniero Luis A. Huergo', 135, 0),
(1840, 'Lamarque', 135, 0),
(1841, 'Las Grutas', 135, 0),
(1842, 'Los Menucos', 135, 0),
(1843, 'Mainqué', 135, 0),
(1844, 'Maquinchao', 135, 0),
(1845, 'Melipal', 135, 0),
(1846, 'Nahuel Malal', 135, 0),
(1847, 'Ñirihuau', 135, 0),
(1848, 'Ñorquinco', 135, 0),
(1849, 'Paso Córdoba', 135, 0),
(1850, 'Pichi Mahuida', 135, 0),
(1851, 'Pilnaniyeu', 135, 0),
(1852, 'Pinar del Lago', 135, 0),
(1853, 'Río Colorado', 135, 0),
(1854, 'San Antonio', 135, 0),
(1855, 'San Carlos de Bariloche', 135, 0),
(1856, 'Sierra Colorada', 135, 0),
(1857, 'Sierra Grande', 135, 0),
(1858, 'Valcheta', 135, 0),
(1859, 'Viedma', 135, 0),
(1860, 'Villa Alberdi', 135, 0),
(1861, 'Villa Llao Llao', 135, 0),
(1862, 'Villa Manzano', 135, 0),
(1863, 'Villa Regina', 135, 0),
(1864, 'Aguaray', 136, 0),
(1865, 'Aguas Blancas', 136, 0),
(1866, 'Animaná', 136, 0),
(1867, 'Anta', 136, 0),
(1868, 'Antilla', 136, 0),
(1869, 'Apolinario Saravia', 136, 0),
(1870, 'Cachi', 136, 0),
(1871, 'Cachi', 136, 0),
(1872, 'Cafayate', 136, 0),
(1873, 'Campamento Vespucio', 136, 0),
(1874, 'Campo Quijano', 136, 0),
(1875, 'Campo Santo', 136, 0),
(1876, 'Cerrillos', 136, 0),
(1877, 'Chicoana', 136, 0),
(1878, 'Cobos', 136, 0),
(1879, 'Coronel Cornejo', 136, 0),
(1880, 'Coronel Juan Solá', 136, 0),
(1881, 'Coronel Moldes', 136, 0),
(1882, 'Coronel Mollinedo', 136, 0),
(1883, 'Dragones', 136, 0),
(1884, 'El Bordo', 136, 0),
(1885, 'El Carril', 136, 0),
(1886, 'El Galpón', 136, 0),
(1887, 'El Jardín', 136, 0),
(1888, 'El Quebrachal', 136, 0),
(1889, 'El Tabacal', 136, 0),
(1890, 'El Tala', 136, 0),
(1891, 'Embarcación', 136, 0),
(1892, 'Gaona', 136, 0),
(1893, 'General Ballivián', 136, 0),
(1894, 'General Guemes', 136, 0),
(1895, 'General Mosconi', 136, 0),
(1896, 'General Pizarro', 136, 0),
(1897, 'General San Martin', 136, 0),
(1898, 'Guachipas', 136, 0),
(1899, 'Hipólito Yrigoyen', 136, 0),
(1900, 'Iruya', 136, 0),
(1901, 'Joaquín V. González', 136, 0),
(1902, 'La Caldera', 136, 0),
(1903, 'La Candelaria', 136, 0),
(1904, 'La Merced', 136, 0),
(1905, 'La Poma', 136, 0),
(1906, 'La Unión', 136, 0),
(1907, 'La Viña', 136, 0),
(1908, 'Las Lajitas', 136, 0),
(1909, 'Los Andes', 136, 0),
(1910, 'Los Blancos', 136, 0),
(1911, 'Mazza', 136, 0),
(1912, 'Metan', 136, 0),
(1913, 'Misión Chaqueña', 136, 0),
(1914, 'Molinos', 136, 0),
(1915, 'Ntra. Señora de Talavera', 136, 0),
(1916, 'Oran', 136, 0),
(1917, 'Pichanal', 136, 0),
(1918, 'Piquete Cabado', 136, 0),
(1919, 'Profesor Salvador', 136, 0),
(1920, 'Río del Valle', 136, 0),
(1921, 'Río Piedras', 136, 0),
(1922, 'Rivadavia', 136, 0),
(1923, 'Ros. de la Frontera', 136, 0),
(1924, 'Rosario de Lerma', 136, 0),
(1925, 'San Agustín', 136, 0),
(1926, 'San Antonio de los Cobres', 136, 0),
(1927, 'San Carlos', 136, 0),
(1928, 'San Lorenzo', 136, 0),
(1929, 'San Ramón de la Nueva Orán', 136, 0),
(1930, 'Santa Rosa', 136, 0),
(1931, 'Santa Victoria', 136, 0),
(1932, 'Tartagal', 136, 0),
(1933, 'Urundel', 136, 0),
(1934, 'Yacuy', 136, 0),
(1935, '25 de Mayo', 137, 0),
(1936, '9 de julio', 137, 0),
(1937, 'Albardon', 137, 0),
(1938, 'Angaco', 137, 0),
(1939, 'Barreal', 137, 0),
(1940, 'Berazategui', 137, 0),
(1941, 'Calingasta', 137, 0),
(1942, 'Caucete', 137, 0),
(1943, 'Chimbas', 137, 0),
(1944, 'Difunta Correa', 137, 0),
(1945, 'El Encón', 137, 0),
(1946, 'Huaco', 137, 0),
(1947, 'Iglesia', 137, 0),
(1948, 'Jachal', 137, 0),
(1949, 'La Rinconada', 137, 0),
(1950, 'Las Flores', 137, 0),
(1951, 'Niquivil', 137, 0),
(1952, 'Pampa Vieja', 137, 0),
(1953, 'Pocito', 137, 0),
(1954, 'Rawson', 137, 0),
(1955, 'Rivadavia', 137, 0),
(1956, 'Rodeo', 137, 0),
(1957, 'San Isidro', 137, 0),
(1958, 'San José de Jáchal', 137, 0),
(1959, 'San Juan', 137, 0),
(1960, 'San Martin', 137, 0),
(1961, 'Santa Lucia', 137, 0),
(1962, 'Sarmiento', 137, 0),
(1963, 'Tamberías', 137, 0),
(1964, 'Tudcum', 137, 0),
(1965, 'Ullum', 137, 0),
(1966, 'Valle Fertil', 137, 0),
(1967, 'Villa Aberastain', 137, 0),
(1968, 'Villa Basilio Nievas', 137, 0),
(1969, 'Villa Del Salvador', 137, 0),
(1970, 'Villa Don Bosco', 137, 0),
(1971, 'Villa Gral. San Martín', 137, 0),
(1972, 'Villa Ibáñez', 137, 0),
(1973, 'Villa Krause', 137, 0),
(1974, 'Villa Media Agua', 137, 0),
(1975, 'Villa Mercedes', 137, 0),
(1976, 'Villa San Agustín del Valle Fértil', 137, 0),
(1977, 'Villa Santa Rosa', 137, 0),
(1978, 'Zonda', 137, 0),
(1979, 'Ayacucho', 138, 0),
(1980, 'Beazley', 138, 0),
(1981, 'Belgrano', 138, 0),
(1982, 'Buena Esperanza', 138, 0),
(1983, 'Candelaria', 138, 0),
(1984, 'Chacabuco', 138, 0),
(1985, 'Concarán', 138, 0),
(1986, 'Coronel Pringles', 138, 0),
(1987, 'Fortuna', 138, 0),
(1988, 'Fraga', 138, 0),
(1989, 'General Pedernera', 138, 0),
(1990, 'Gobernador Dupuy', 138, 0),
(1991, 'Junin', 138, 0),
(1992, 'Justo Daract', 138, 0),
(1993, 'La Calera', 138, 0),
(1994, 'La Toma', 138, 0),
(1995, 'Las Isletas', 138, 0),
(1996, 'Ldor Gral San Martin', 138, 0),
(1997, 'Luján', 138, 0),
(1998, 'Mercedes', 138, 0),
(1999, 'Merlo', 138, 0),
(2000, 'Quines', 138, 0),
(2001, 'San Francisco del Monte de Oro', 138, 0),
(2002, 'San Luis', 138, 0),
(2003, 'Santa Rosa del Conlara', 138, 0),
(2004, 'Tilisarao', 138, 0),
(2005, 'Trapiche', 138, 0),
(2006, 'Unión', 138, 0),
(2007, 'Villa General Roca', 138, 0),
(2008, 'Villa Mercedes', 138, 0),
(2009, 'Villa Reynolds', 138, 0),
(2010, '28 de Noviembre', 139, 0),
(2011, 'Caleta Olivia', 139, 0),
(2012, 'Cañadon Seco', 139, 0),
(2013, 'Comandante Luis Peidrabuena', 139, 0),
(2014, 'Corpen Aike', 139, 0),
(2015, 'Deseado', 139, 0),
(2016, 'El Calafate', 139, 0),
(2017, 'Gobernador Gregores', 139, 0),
(2018, 'Guer Aike', 139, 0),
(2019, 'Lago Argentino', 139, 0),
(2020, 'Lago Buenos Aires', 139, 0),
(2021, 'Las Heras', 139, 0),
(2022, 'Los Antiguos', 139, 0),
(2023, 'Magallanes', 139, 0),
(2024, 'Mina 3', 139, 0),
(2025, 'Perito Moreno', 139, 0),
(2026, 'Pico Truncado', 139, 0),
(2027, 'Puerto Deseado', 139, 0),
(2028, 'Puerto San Julian', 139, 0),
(2029, 'Puerto Santa Cruz', 139, 0),
(2030, 'Rio Chico', 139, 0),
(2031, 'Rio Gallegos', 139, 0),
(2032, 'Rospentek Aike', 139, 0),
(2033, 'Yacimientos Río Turbio', 139, 0),
(2034, '9 De Julio', 140, 0),
(2035, 'Acebal', 140, 0),
(2036, 'Alcorta', 140, 0),
(2037, 'Aldao', 140, 0),
(2038, 'Alejandra', 140, 0),
(2039, 'Alvarez', 140, 0),
(2040, 'Alvear', 140, 0),
(2041, 'Ambrosetti', 140, 0),
(2042, 'Amenábar', 140, 0),
(2043, 'Angélica', 140, 0),
(2044, 'Arequito', 140, 0),
(2045, 'Armstrong', 140, 0),
(2046, 'Arocena', 140, 0),
(2047, 'Arroyo Aguilar', 140, 0),
(2048, 'Arroyo Seco', 140, 0),
(2049, 'Arrufo', 140, 0),
(2050, 'Arteaga', 140, 0),
(2051, 'Ataliva', 140, 0),
(2052, 'Avellaneda', 140, 0),
(2053, 'Barrancas', 140, 0),
(2054, 'Belgrano', 140, 0),
(2055, 'Berabevú', 140, 0),
(2056, 'Berna', 140, 0),
(2057, 'Bernardo de Irigoyen', 140, 0),
(2058, 'Bigand', 140, 0),
(2059, 'Bombal', 140, 0),
(2060, 'Bouquet', 140, 0),
(2061, 'Bustinza', 140, 0),
(2062, 'Cafferata', 140, 0),
(2063, 'Calchaquí', 140, 0),
(2064, 'Can Cristóbal', 140, 0),
(2065, 'Cañada de Gomez', 140, 0),
(2066, 'Cañada Del Ucle', 140, 0),
(2067, 'Cañada Rica', 140, 0),
(2068, 'Cañada Rosquín', 140, 0),
(2069, 'Capitán Bermúdez', 140, 0),
(2070, 'Carcarañá', 140, 0),
(2071, 'Carlos Pellegrini', 140, 0),
(2072, 'Carmen', 140, 0),
(2073, 'Carreras', 140, 0),
(2074, 'Carrizales', 140, 0),
(2075, 'Casas', 140, 0),
(2076, 'Caseros', 140, 0),
(2077, 'Casilda', 140, 0),
(2078, 'Castellanos', 140, 0),
(2079, 'Cayastá', 140, 0),
(2080, 'Centeno', 140, 0),
(2081, 'Cepeda', 140, 0),
(2082, 'Ceres', 140, 0),
(2083, 'Chabás', 140, 0),
(2084, 'Chañar Ladeado', 140, 0),
(2085, 'Charas', 140, 0),
(2086, 'Chovet', 140, 0),
(2087, 'Clucellas', 140, 0),
(2088, 'Colonia Belgrano', 140, 0),
(2089, 'Colonia Margarita', 140, 0),
(2090, 'Constitucion', 140, 0),
(2091, 'Coronda', 140, 0),
(2092, 'Coronel Arnold', 140, 0),
(2093, 'Coronel Bogado', 140, 0),
(2094, 'Coronel Rodolfo S. Dominguez', 140, 0),
(2095, 'Correa', 140, 0),
(2096, 'Cptan. Bermúdez', 140, 0),
(2097, 'Desvío Arijón', 140, 0),
(2098, 'Díaz', 140, 0),
(2099, 'Diego de Alvear', 140, 0),
(2100, 'El Trébol', 140, 0),
(2101, 'Elisa', 140, 0),
(2102, 'Elortondo', 140, 0),
(2103, 'Empalme Villa Constitución', 140, 0),
(2104, 'Esmeralda', 140, 0),
(2105, 'Esperanza', 140, 0),
(2106, 'Esther', 140, 0),
(2107, 'Eusebia', 140, 0),
(2108, 'Felicia', 140, 0),
(2109, 'Fighiera', 140, 0),
(2110, 'Firmat', 140, 0),
(2111, 'Florencia', 140, 0),
(2112, 'Fortín Olmos', 140, 0),
(2113, 'Franck', 140, 0),
(2114, 'Fray Luis Beltrán', 140, 0),
(2115, 'Frontera', 140, 0),
(2116, 'Fuentes', 140, 0),
(2117, 'Funes', 140, 0),
(2118, 'Gaboto', 140, 0),
(2119, 'Gálvez', 140, 0),
(2120, 'Garaboto', 140, 0),
(2121, 'Garay', 140, 0),
(2122, 'Gato Colorado', 140, 0),
(2123, 'Gdero. Baigorria', 140, 0),
(2124, 'General Gelly', 140, 0),
(2125, 'General Lagos', 140, 0),
(2126, 'General Lopez', 140, 0),
(2127, 'General Obligado', 140, 0),
(2128, 'Gessler', 140, 0),
(2129, 'Gobernador Candioti', 140, 0),
(2130, 'Gobernador Crespo', 140, 0),
(2131, 'Gobernador Gálvez', 140, 0),
(2132, 'Gödeken', 140, 0),
(2133, 'Godoy', 140, 0),
(2134, 'Granadero Baigorria', 140, 0),
(2135, 'Gregoria Pérez de Denis', 140, 0),
(2136, 'Grutly', 140, 0),
(2137, 'Helvecia', 140, 0),
(2138, 'Hersilia', 140, 0),
(2139, 'Huanqueros', 140, 0),
(2140, 'Hughes', 140, 0),
(2141, 'Humberto I', 140, 0),
(2142, 'Humboldt', 140, 0),
(2143, 'Ibarlucea', 140, 0),
(2144, 'Intiyaco', 140, 0),
(2145, 'Irigoyen', 140, 0),
(2146, 'Iriondo', 140, 0),
(2147, 'Josefina', 140, 0),
(2148, 'Juan B. Molina', 140, 0),
(2149, 'Juncal', 140, 0),
(2150, 'La Criolla', 140, 0),
(2151, 'La Gallareta', 140, 0),
(2152, 'La Pelada', 140, 0),
(2153, 'Labordeboy', 140, 0),
(2154, 'Laguna Paiva', 140, 0),
(2155, 'Landeta', 140, 0),
(2156, 'Lanteri', 140, 0),
(2157, 'Las Colonias', 140, 0),
(2158, 'Las Garzas', 140, 0),
(2159, 'Las Palmeras', 140, 0),
(2160, 'Las Parejas', 140, 0),
(2161, 'Las Petacas', 140, 0),
(2162, 'Las Rosas', 140, 0),
(2163, 'Las Toscas', 140, 0),
(2164, 'Lehmann', 140, 0),
(2165, 'Llambi Campbell', 140, 0),
(2166, 'López', 140, 0),
(2167, 'Los Amores', 140, 0),
(2168, 'Los Cardos', 140, 0),
(2169, 'Los Molinos', 140, 0),
(2170, 'Los Quirquinchos', 140, 0),
(2171, 'Maciel ', 140, 0),
(2172, 'Maggiolo', 140, 0),
(2173, 'Malabrigo', 140, 0),
(2174, 'Marcelino Escalada', 140, 0),
(2175, 'Margarita', 140, 0),
(2176, 'María Juana', 140, 0),
(2177, 'María Teresa', 140, 0),
(2178, 'Matilde', 140, 0),
(2179, 'Máximo Paz', 140, 0),
(2180, 'Melincué', 140, 0),
(2181, 'Moisés Ville', 140, 0),
(2182, 'Monje', 140, 0),
(2183, 'Monte Vera', 140, 0),
(2184, 'Montes de Oca', 140, 0),
(2185, 'Murphy', 140, 0),
(2186, 'Nelson', 140, 0),
(2187, 'Oliveros', 140, 0),
(2188, 'Palacios', 140, 0),
(2189, 'Pavón', 140, 0),
(2190, 'Pavón Arriba', 140, 0),
(2191, 'Pedro Gomez Cello', 140, 0),
(2192, 'Pérez', 140, 0),
(2193, 'Peyrano', 140, 0),
(2194, 'Piamonte', 140, 0),
(2195, 'Pilar', 140, 0),
(2196, 'Piñero', 140, 0),
(2197, 'Plaza Clucellas', 140, 0),
(2198, 'Pozo Borrado', 140, 0),
(2199, 'Progreso', 140, 0),
(2200, 'Providencia', 140, 0),
(2201, 'Pueblo Andino', 140, 0),
(2202, 'Pueblo Muñoz', 140, 0),
(2203, 'Pujato', 140, 0),
(2204, 'Reconquista', 140, 0),
(2205, 'Recreo', 140, 0),
(2206, 'Ricardone', 140, 0),
(2207, 'Roldán', 140, 0),
(2208, 'Romang', 140, 0),
(2209, 'Rufino', 140, 0),
(2210, 'Sa. Pereyra', 140, 0),
(2211, 'Salto Grande', 140, 0),
(2212, 'San Antonio de Obligado', 140, 0),
(2213, 'San Carlos Centro', 140, 0),
(2214, 'San Carlos Norte', 140, 0),
(2215, 'San Carlos Sur', 140, 0),
(2216, 'San Cristobal', 140, 0),
(2217, 'San Eduardo', 140, 0),
(2218, 'San Fabián', 140, 0),
(2219, 'San Genaro', 140, 0),
(2220, 'San Genaro Norte', 140, 0),
(2221, 'San Gregorio', 140, 0),
(2222, 'San Javier', 140, 0),
(2223, 'San Jeronimo', 140, 0),
(2224, 'San Jerónimo Norte', 140, 0),
(2225, 'San Jerónimo Sur', 140, 0),
(2226, 'San Jorge', 140, 0),
(2227, 'San José de la Esquina', 140, 0),
(2228, 'San Justo', 140, 0),
(2229, 'San Lorenzo', 140, 0),
(2230, 'San Martin', 140, 0),
(2231, 'San Vicente', 140, 0),
(2232, 'Sancti Spíritu', 140, 0),
(2233, 'Sanford', 140, 0),
(2234, 'Santa Clara de Buena Vista', 140, 0),
(2235, 'Santa Clara de Saguier', 140, 0),
(2236, 'Santa Isabel', 140, 0),
(2237, 'Santa Margarita', 140, 0),
(2238, 'Santa Rosa de Calchines', 140, 0),
(2239, 'Santa Teresa', 140, 0),
(2240, 'Santo Domingo', 140, 0),
(2241, 'Santo Tome', 140, 0),
(2242, 'Sargento Cabral', 140, 0),
(2243, 'Sarmiento', 140, 0),
(2244, 'Sastre', 140, 0),
(2245, 'Sauce Viejo', 140, 0),
(2246, 'Serodino', 140, 0),
(2247, 'Soldini', 140, 0),
(2248, 'Soledad', 140, 0),
(2249, 'Sunchales', 140, 0),
(2250, 'Susana', 140, 0),
(2251, 'Tacuarendí', 140, 0),
(2252, 'Tacural', 140, 0),
(2253, 'Tartagal', 140, 0),
(2254, 'Teodelina', 140, 0),
(2255, 'Theobald', 140, 0),
(2256, 'Timbúes', 140, 0),
(2257, 'Tortugas', 140, 0),
(2258, 'Tostado', 140, 0),
(2259, 'Totoras', 140, 0),
(2260, 'Uranga', 140, 0),
(2261, 'Vera', 140, 0),
(2262, 'Vera y Pintado', 140, 0),
(2263, 'Videla', 140, 0),
(2264, 'Vila', 140, 0),
(2265, 'Villa Ana', 140, 0),
(2266, 'Villa Cañás', 140, 0),
(2267, 'Villa Constitución', 140, 0),
(2268, 'Villa Eloísa', 140, 0),
(2269, 'Villa Gdor. Gálvez', 140, 0),
(2270, 'Villa Guillermina', 140, 0),
(2271, 'Villa Minetti', 140, 0),
(2272, 'Villa Mugueta', 140, 0),
(2273, 'Villa Ocampo', 140, 0),
(2274, 'Villa Trinidad', 140, 0),
(2275, 'Villada', 140, 0),
(2276, 'Wheelwright', 140, 0),
(2277, 'Zavalla', 140, 0),
(2278, 'Zenón Pereyra', 140, 0),
(2279, 'Aguirre', 141, 0),
(2280, 'Alberdi', 141, 0),
(2281, 'Añatuya', 141, 0),
(2282, 'Arraga', 141, 0),
(2283, 'Atamisqui', 141, 0),
(2284, 'Avellaneda', 141, 0),
(2285, 'Badera Bajada', 141, 0),
(2286, 'Banda', 141, 0),
(2287, 'Bandera', 141, 0),
(2288, 'Belgrano', 141, 0),
(2289, 'Brea Pozo', 141, 0),
(2290, 'Campo Gallo', 141, 0);
INSERT INTO `location` (`location_id`, `location_name`, `location_parent`, `location_order`) VALUES
(2291, 'Choya', 141, 0),
(2292, 'Ciudad de Loreto', 141, 0),
(2293, 'Clodomira', 141, 0),
(2294, 'Colonia Dora', 141, 0),
(2295, 'Colonia El Simbolar', 141, 0),
(2296, 'Copo', 141, 0),
(2297, 'El Caburá', 141, 0),
(2298, 'El Charco', 141, 0),
(2299, 'El Mojón', 141, 0),
(2300, 'Fernández', 141, 0),
(2301, 'Figueroa', 141, 0),
(2302, 'Frías', 141, 0),
(2303, 'Garza', 141, 0),
(2304, 'General Taboada', 141, 0),
(2305, 'Guardia Escolta', 141, 0),
(2306, 'Guasayan', 141, 0),
(2307, 'Herrera', 141, 0),
(2308, 'Icaño', 141, 0),
(2309, 'Jimenez', 141, 0),
(2310, 'Juan F. Ibarra', 141, 0),
(2311, 'La Aurora', 141, 0),
(2312, 'La Banda', 141, 0),
(2313, 'La Cañada', 141, 0),
(2314, 'La Fragua', 141, 0),
(2315, 'Laprida', 141, 0),
(2316, 'Lavalle', 141, 0),
(2317, 'Loreto', 141, 0),
(2318, 'Los Juríes', 141, 0),
(2319, 'Los Nuñez', 141, 0),
(2320, 'Los Pirpintos', 141, 0),
(2321, 'Los Quiroga', 141, 0),
(2322, 'Los Telares', 141, 0),
(2323, 'Lugones', 141, 0),
(2324, 'Malbrán', 141, 0),
(2325, 'Matará', 141, 0),
(2326, 'Mitre', 141, 0),
(2327, 'Monte Quemado', 141, 0),
(2328, 'Moreno', 141, 0),
(2329, 'Nueva Esperanza', 141, 0),
(2330, 'Nueva Francia', 141, 0),
(2331, 'Ojo de agua', 141, 0),
(2332, 'Pampa de los Guanacos', 141, 0),
(2333, 'Pelegrini', 141, 0),
(2334, 'Pinto', 141, 0),
(2335, 'Pozo Hondo', 141, 0),
(2336, 'Quebrachos', 141, 0),
(2337, 'Quimilí', 141, 0),
(2338, 'Rapelli', 141, 0),
(2339, 'Real Sayana', 141, 0),
(2340, 'Rio Hondo', 141, 0),
(2341, 'Rivadavia', 141, 0),
(2342, 'Robles', 141, 0),
(2343, 'Sachayoj', 141, 0),
(2344, 'Salavina', 141, 0),
(2345, 'San Martin', 141, 0),
(2346, 'San Pedro', 141, 0),
(2347, 'Santiago del Estero', 141, 0),
(2348, 'Sarmiento', 141, 0),
(2349, 'Selva', 141, 0),
(2350, 'Silipica', 141, 0),
(2351, 'Simbolar', 141, 0),
(2352, 'Sol de Julio', 141, 0),
(2353, 'Sumampa', 141, 0),
(2354, 'Suncho Corral', 141, 0),
(2355, 'Tapso', 141, 0),
(2356, 'Termas de Río Hondo', 141, 0),
(2357, 'Tintina', 141, 0),
(2358, 'Vilelas', 141, 0),
(2359, 'Villa Atamisqui', 141, 0),
(2360, 'Villa La Punta', 141, 0),
(2361, 'Villa Ojo de Agua', 141, 0),
(2362, 'Villa Río Hondo', 141, 0),
(2363, 'Lapataia', 142, 0),
(2364, 'San Sebastián', 142, 0),
(2365, 'Tolhuin', 142, 0),
(2366, 'Ushuaia', 142, 0),
(2367, 'Acheral', 143, 0),
(2368, 'Aguilares', 143, 0),
(2369, 'Alderetes', 143, 0),
(2370, 'Alpachiri', 143, 0),
(2371, 'Alto Verde', 143, 0),
(2372, 'Amaichá del Valle', 143, 0),
(2373, 'Aráoz', 143, 0),
(2374, 'Arcadia', 143, 0),
(2375, 'Banda del Río Salí', 143, 0),
(2376, 'Bella Vista', 143, 0),
(2377, 'Benjamín Aráoz', 143, 0),
(2378, 'Burruyacu', 143, 0),
(2379, 'Chicligasta', 143, 0),
(2380, 'Colombres', 143, 0),
(2381, 'Colorado del Valle', 143, 0),
(2382, 'Concepción', 143, 0),
(2383, 'Cruz Alta', 143, 0),
(2384, 'El Chañar', 143, 0),
(2385, 'El Mollar', 143, 0),
(2386, 'Famaillá', 143, 0),
(2387, 'Famaillá', 143, 0),
(2388, 'Gobernador Garmendia', 143, 0),
(2389, 'Graneros', 143, 0),
(2390, 'Independencia', 143, 0),
(2391, 'Juan B. Alberdi', 143, 0),
(2392, 'La Cocha', 143, 0),
(2393, 'La Ramada', 143, 0),
(2394, 'La Reducción', 143, 0),
(2395, 'La Trinidad', 143, 0),
(2396, 'Lamadrid', 143, 0),
(2397, 'Las Cejas', 143, 0),
(2398, 'Leales', 143, 0),
(2399, 'Los Ralos', 143, 0),
(2400, 'Los Sarmientos', 143, 0),
(2401, 'Lules', 143, 0),
(2402, 'Manuel García Fernández', 143, 0),
(2403, 'Monteagudo', 143, 0),
(2404, 'Monteros', 143, 0),
(2405, 'Ranchillos', 143, 0),
(2406, 'Rio Chico', 143, 0),
(2407, 'Río Colorado', 143, 0),
(2408, 'Río Seco', 143, 0),
(2409, 'San Pablo', 143, 0),
(2410, 'San Pedro de Colalao', 143, 0),
(2411, 'Santa Ana', 143, 0),
(2412, 'Santa Lucía', 143, 0),
(2413, 'Santa Rosa de Leales', 143, 0),
(2414, 'Simoca', 143, 0),
(2415, 'Taco Ralo', 143, 0),
(2416, 'Tafí del Valle', 143, 0),
(2417, 'Tafi Viejo', 143, 0),
(2418, 'Trancas', 143, 0),
(2419, 'Villa Belgrano', 143, 0),
(2420, 'Villa C. Hileret', 143, 0),
(2421, 'Villa Carmela', 143, 0),
(2422, 'Villa Fiad', 143, 0),
(2423, 'Villa Mariano Moreno', 143, 0),
(2424, 'Villa Quinteros', 143, 0),
(2425, 'Yerba Buena', 143, 0),
(231, 'Escobar', 116, 0),
(232, 'Tigre', 116, 0),
(233, 'General San Martín', 116, 0),
(2426, 'General Rodriguez', 117, 0),
(2427, 'Hurlingham', 117, 0),
(2428, 'Ituzaingó', 117, 0),
(2429, 'José C. Paz', 117, 0),
(2430, 'Malvinas Argentinas', 117, 0),
(2431, 'Marcos Paz', 117, 0),
(2432, 'Merlo', 117, 0),
(2433, 'Moreno', 117, 0),
(2434, 'San Miguel', 117, 0),
(2435, 'Tres de Febrero', 117, 0),
(2436, 'Almirante Brown', 118, 0),
(2437, 'Avellaneda', 118, 0),
(2438, 'Berazategui', 118, 0),
(2439, 'Esteban Echeverría', 118, 0),
(2440, 'Ezeiza', 118, 0),
(2441, 'Florencio Varela', 118, 0),
(2442, 'Lomas de Zamora', 118, 0),
(2443, 'Presidente Perón', 118, 0),
(2444, 'San Vicente', 118, 0);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL,
  `menu_name` varchar(255) DEFAULT '',
  `menu_parent` int(11) NOT NULL DEFAULT '0',
  `menu_url` varchar(255) DEFAULT '',
  `menu_order` int(5) NOT NULL DEFAULT '0',
  `menu_state` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menu_id`, `menu_name`, `menu_parent`, `menu_url`, `menu_order`, `menu_state`) VALUES
(1, 'ZonaJobs Educacion', 0, '#', 0, 1),
(2, 'Inicio', 1, '/', 1, 1),
(3, 'Carreras y Terciarios', 1, '/carreras-y-terciarios', 2, 1),
(4, 'Test Vocacional', 1, '/test-vocacional', 5, 1),
(7, 'Posgrados y Maestrías', 1, '/posgrados-y-maestrias', 3, 1),
(12, 'Cursos', 1, '/cursos', 4, 1),
(17, 'Notas', 1, '/notas', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `multimedia`
--

DROP TABLE IF EXISTS `multimedia`;
CREATE TABLE `multimedia` (
  `multimedia_id` int(11) NOT NULL,
  `multimedia_typeid` int(11) NOT NULL DEFAULT '0',
  `multimedia_source` varchar(10) NOT NULL DEFAULT '',
  `multimedia_weight` int(15) NOT NULL DEFAULT '0',
  `multimedia_parent` int(11) NOT NULL DEFAULT '0',
  `multimedia_title` varchar(500) DEFAULT '',
  `multimedia_content` text,
  `multimedia_state` int(1) NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `creation_userid` int(4) NOT NULL DEFAULT '0',
  `creation_usertype` varchar(50) DEFAULT '',
  `modification_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modification_userid` int(4) NOT NULL DEFAULT '0',
  `modification_usertype` varchar(50) DEFAULT '',
  `object_custom` text
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `multimedia_category`
--

DROP TABLE IF EXISTS `multimedia_category`;
CREATE TABLE `multimedia_category` (
  `multimedia_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `category_parentid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `multimedia_deleted`
--

DROP TABLE IF EXISTS `multimedia_deleted`;
CREATE TABLE `multimedia_deleted` (
  `multimedia_id` int(11) NOT NULL,
  `multimedia_typeid` int(11) NOT NULL DEFAULT '0',
  `multimedia_source` varchar(10) NOT NULL DEFAULT '',
  `multimedia_weight` int(15) NOT NULL DEFAULT '0',
  `multimedia_parent` int(11) NOT NULL DEFAULT '0',
  `multimedia_title` varchar(500) DEFAULT '',
  `multimedia_content` text,
  `multimedia_state` int(1) NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `creation_userid` int(11) NOT NULL DEFAULT '0',
  `creation_usertype` varchar(50) DEFAULT '',
  `modification_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modification_userid` int(11) NOT NULL DEFAULT '0',
  `modification_usertype` varchar(50) DEFAULT '',
  `object_custom` text
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `multimedia_deleted`
--

INSERT INTO `multimedia_deleted` (`multimedia_id`, `multimedia_typeid`, `multimedia_source`, `multimedia_weight`, `multimedia_parent`, `multimedia_title`, `multimedia_content`, `multimedia_state`, `creation_date`, `creation_userid`, `creation_usertype`, `modification_date`, `modification_userid`, `modification_usertype`, `object_custom`) VALUES
(48, 1, 'jpg', 102303, 0, 'tumblr_lqwnbayekS1qzr53co1_1280.jpg', '', 0, '2013-11-04 21:56:01', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"853";s:10:"height-att";s:4:"1280";}'),
(47, 1, 'jpg', 127035, 0, 'tumblr_lqvh9bbxxo1qzr53co1_1280.jpg', '', 0, '2013-11-04 21:56:00', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"600";s:10:"height-att";s:3:"916";}'),
(46, 1, 'jpg', 202316, 0, 'tumblr_lqunz5Y6u81qzr53co1_1280.jpg', '', 0, '2013-11-04 21:56:00', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"567";s:10:"height-att";s:3:"850";}'),
(45, 1, 'jpg', 286395, 0, 'tumblr_lqujey7Rnx1qzr53co1_1280.jpg', '', 0, '2013-11-04 21:56:00', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"967";s:10:"height-att";s:4:"1280";}'),
(44, 1, 'jpg', 68139, 0, 'tumblr_lqqt8bRHTv1qzr53co1_1280.jpg', '', 0, '2013-11-04 21:55:59', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"570";s:10:"height-att";s:3:"856";}'),
(43, 1, 'png', 318184, 0, 'tumblr_mgc20zDlSz1r5vp1oo1_500.png', '', 0, '2013-11-04 21:50:46', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}'),
(42, 1, 'jpg', 80194, 0, 'tumblr_me22eqHqeu1r5vp1oo1_r3_500.jpg', '', 0, '2013-11-04 21:50:45', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}'),
(41, 1, 'jpg', 136495, 0, 'tumblr_me5umiHgVb1r5vp1oo1_500.jpg', NULL, 0, '2013-11-04 21:47:46', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}'),
(40, 1, 'jpg', 165862, 0, 'tumblr_m79lttf60u1qlo9hgo1_500.jpg', NULL, 0, '2013-11-04 21:47:42', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}'),
(39, 1, 'jpg', 97365, 0, 'tumblr_m24bgh0e6d1r5vp1oo1_500.jpg', NULL, 0, '2013-11-04 21:47:38', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}'),
(38, 1, 'jpg', 381002, 0, '142368964_adriana_lima_vsbombshell2_122_130lo.jpg', ' ', 0, '2013-11-04 21:25:15', 0, '', '0000-00-00 00:00:00', 0, '', 'a:1:{s:4:"tags";s:0:"";}'),
(37, 1, 'jpg', 238580, 0, '323983708_rosie_huntington_whiteley_maxim2_123_451lo.jpg', ' ', 0, '2013-11-04 21:23:54', 0, '', '0000-00-00 00:00:00', 0, '', 'a:1:{s:4:"tags";s:0:"";}'),
(36, 1, 'jpg', 193321, 0, '936full-irina-shayk.jpg', ' ', 0, '2013-11-01 16:55:32', 0, '', '0000-00-00 00:00:00', 0, '', 'a:1:{s:4:"tags";s:0:"";}'),
(35, 1, 'jpg', 449331, 0, '73709-original.jpg', NULL, 0, '2013-10-29 22:47:48', 0, '', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"580";s:10:"height-att";s:3:"600";}'),
(29, 1, 'jpg', 35312, 0, 'Estudiar posgrados.jpg', '', 0, '2013-01-16 14:34:19', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"400";s:10:"height-att";s:3:"602";}'),
(31, 1, 'jpg', 20624, 0, 'Un pasaporte.jpg', '', 0, '2013-01-16 14:34:19', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"400";s:10:"height-att";s:3:"267";}'),
(30, 1, 'jpg', 37262, 0, 'Mayor capacitacion.jpg', '', 0, '2013-01-16 14:34:19', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"400";s:10:"height-att";s:3:"602";}'),
(28, 1, 'jpg', 14868, 0, '5 profesiones', '  ', 0, '2013-01-16 14:34:19', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:3:{s:9:"width-att";s:3:"400";s:10:"height-att";s:3:"266";s:4:"tags";s:0:"";}');

-- --------------------------------------------------------

--
-- Table structure for table `multimedia_object`
--

DROP TABLE IF EXISTS `multimedia_object`;
CREATE TABLE `multimedia_object` (
  `object_id` int(11) NOT NULL DEFAULT '0',
  `multimedia_id` int(11) NOT NULL DEFAULT '0',
  `relation_order` int(3) NOT NULL DEFAULT '0',
  `object_typeid` int(11) NOT NULL DEFAULT '0',
  `multimedia_typeid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `object`
--

DROP TABLE IF EXISTS `object`;
CREATE TABLE `object` (
  `object_id` int(11) NOT NULL,
  `object_typeid` int(11) NOT NULL DEFAULT '0',
  `object_parent` int(11) NOT NULL DEFAULT '0',
  `object_title` varchar(500) DEFAULT '',
  `object_shorttitle` varchar(255) DEFAULT '',
  `object_content` text,
  `object_summary` text,
  `object_tags` varchar(255) DEFAULT NULL,
  `creation_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `creation_userid` int(4) NOT NULL DEFAULT '0',
  `creation_usertype` varchar(50) DEFAULT '',
  `modification_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modification_userid` int(4) NOT NULL DEFAULT '0',
  `modification_usertype` varchar(50) DEFAULT '',
  `publication_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publication_userid` int(4) NOT NULL DEFAULT '0',
  `object_state` int(1) NOT NULL DEFAULT '0',
  `site_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) NOT NULL DEFAULT '0',
  `object_custom` text
) ENGINE=MyISAM AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `object`
--

INSERT INTO `object` (`object_id`, `object_typeid`, `object_parent`, `object_title`, `object_shorttitle`, `object_content`, `object_summary`, `object_tags`, `creation_date`, `creation_userid`, `creation_usertype`, `modification_date`, `modification_userid`, `modification_usertype`, `publication_date`, `publication_userid`, `object_state`, `site_id`, `location_id`, `object_custom`) VALUES
(175, 3, 0, 'Quienes Somos', 'quienes-somos', '<p class="p1"><span class="s1"><strong>ZonaJobs · Educación</strong></span><span class="s2"><strong> </strong>es un portal diseñado para facilitar la interacción entre potenciales estudiantes e instituciones educativas. </span></p>\r\n<p class="p1"><span class="s1"><strong>ZonaJobs · Educación</strong></span><span class="s2"><strong> </strong>tiene los siguientes objetivos:<br /><strong></strong></span></p>\r\n<p class="p1"><span class="s2"><strong>1) Que todas las personas encuentren su verdadera vocación.</strong></span></p>\r\n<p class="p1"><span class="s1"><strong>2) Que todos nuestros usuarios puedan crecer profesional y personalmente realizando carreras, cursos y posgrados.</strong></span></p>\r\n<p class="p1"><span class="s1">Somos parte de </span><span class="s2"><strong>ZonaJobs</strong></span><span class="s1">, el portal de empleos líder de </span>Latinoamérica. </p>\r\n<p class="p1"><span class="s1">Desde el 2006 operamos en Argentina, Brasil, Chile, Colombia, México, Perú y Venezuela. </span></p>\r\n<p class="p1"><span class="s1">Si tienes alguna duda o sugerencia para hacernos, escríbenos a través de nuestro</span><span class="s2"> <a href="http://www.zonajobs.com.ar/varios/contactenos.asp"><span class="s3">formulario de contacto.</span></a></span></p>\r\n<p class="p1"><span class="s1"><br /></span></p>', NULL, NULL, '2013-02-26 18:46:43', 1, 'backend', '2013-02-26 18:55:58', 1, 'backend', '2013-02-26 18:57:37', 1, 1, 0, 0, 'a:3:{s:9:"metatitle";s:13:"Quienes Somos";s:15:"metadescription";s:0:"";s:4:"tags";s:0:"";}'),
(176, 3, 0, 'Preguntas frecuentes', 'preguntas-frecuentes', '<p><strong>Preguntas frecuentes para Usuarios</strong><br /> <a href="#preg1">¿Cuánto cuesta utilizar los servicios de ZonaJobs Educación?</a><br /> <a href="#preg2">¿Tengo que estar registrado para poder buscar una carrera?<br /> </a><a href="#preg3">¿Cómo busco carreras, cursos o posgrados en el sitio?<br /> </a><a href="#preg4">¿Cómo busco por palabra clave en el buscador?</a><a href="#preg3"><br /> </a><a href="#preg5">¿Puedo obtener más datos acerca de una carrera, curso o posgrado?</a><a href="#preg3"><br /> </a><a href="#preg6">¿Puedo obtener más datos acerca de una Universidad específica?</a><a href="#preg3"><br /> </a><a href="#preg7">¿Qué sucede con mis datos al llenar el formulario de contacto?</a><a href="#preg3"><br /> </a><a href="#preg8">¿Cómo hace una institución para contactarse conmigo?</a><a href="#preg3"><br /> </a><a href="#preg9">Todavía no definí lo que quiero estudiar, ¿qué debo hacer?</a><a href="#preg3"><br /> </a><a href="#preg10">Realicé el test vocacional pero tengo algunas dudas sobre el resultado, ¿qué puedo hacer?</a><a href="#preg3"><br /> </a><a href="#preg11">¿Qué es una carrera universitaria?</a><a href="#preg3"><br /> </a><a href="#preg12">¿Por qué estudiar una carrera universitaria o un terciario? </a><a href="#preg3"><br /> </a><a href="#preg13">¿Qué es un posgrado?</a><a href="#preg3"><br /> </a><a href="#preg14">¿Por qué debo estudiar un posgrado?</a><a href="#preg3"><br /> </a><a href="#preg15">¿Qué es un curso?</a><a href="#preg3"><br /> </a><a href="#preg16">¿Por qué debo estudiar un curso?</a><a href="#preg3"><br /> </a><a href="#preg17">Quiero realizar una consulta o sugerencia, ¿cómo lo hago?</a></p>\r\n<p><strong>Preguntas frecuentes para Instituciones Educativas</strong><br /> <a href="#preg18">¿Cómo funciona ZonaJobs Educación?</a><br /> <a href="#preg19">¿Cómo registro mi Institución?</a><br /> <a href="#preg20">¿Cómo publico un curso, carrera o posgrado?</a><br /> <a href="#preg21">¿Qué tipo de instituciones pueden registrarse en ZonaJobs Educación?</a><br /> <a href="#preg22">¿Cómo destaco mi instituto? </a><br /> <a href="#preg23">¿Puedo destacar una carrera específica?</a><br /> <a href="#preg24">¿Cómo contacto a los interesados en mi institución?</a><br /> <a href="#preg25">Quiero realizar una consulta o sugerencia a ZonaJobs Educación, ¿cómo puedo hacer?</a></p>\r\n<p> </p>\r\n<p id="preg1"><strong>¿Cuánto cuesta utilizar los servicios de ZonaJobs Educación?</strong></p>\r\n<p>El servicio de búsqueda de ofertas educativas de <strong>ZonaJobs Educación</strong> es <strong>totalmente gratuito</strong> y te permitirá solicitar información a todos los cursos, carreras y posgrados que desees.</p>\r\n<p id="preg2"><strong>¿Tengo que estar registrado para poder buscar una carrera?</strong></p>\r\n<p>Para utilizar el servicio de búsqueda de carrera no necesitas generar un usuario y una contraseña, puedes hacerlo libremente y solicitar información a todas las instituciones que desees de manera libre y gratuita. </p>\r\n<p id="preg3"><strong>¿Cómo busco carreras, cursos o posgrados en el sitio?</strong></p>\r\n<p>En la página principal de <strong>ZonaJobs Educación</strong>, encontrarás un <strong>Buscador de Carreras</strong> que tiene 4 campos de búsqueda. Ellos son: <strong>Palabra Clave</strong>, <strong>Ubicación (por zona), Modalidad (si es presencial o a distancia) y Nivel (si buscas una carrera, será grado)</strong>. Deberás seleccionar al menos una opción para que se listen todas las carreras que cumplan con los criterios que seleccionaste.</p>\r\n<p id="preg4"><strong>¿Cómo busco por palabra clave en el buscador?</strong></p>\r\n<p>Simplemente deberás escribir una o varias palabras en el campo <strong>Palabra Clave</strong> que se encuentra dentro del buscador de la página principal de <strong>ZonaJobs Educación</strong>. </p>\r\n<p id="preg5"><strong>¿Puedo obtener más datos acerca de una carrera, curso o posgrado?</strong></p>\r\n<p>Si. Para obtener más datos de una oferta educativa debes hacer clic en “Solicitar información” y llenar los datos de contacto solicitados, la institución se contactará contigo a la brevedad para explicarte los detalles que te interesen sobre la carrera, curso o posgrado.</p>\r\n<p id="preg6"><strong>¿Puedo obtener más datos acerca de una Universidad específica?</strong></p>\r\n<p>Si. Para ver los datos de una Universidad o Institución específica puedes escribir su nombre en el buscador o hacer clic sobre su nombre o su logo. Allí entrarás al perfil de la universidad y podrás ver su resumen, además podrás presionar el botón “Solicitar información” y completar los datos de contacto solicitados, la institución se contactará contigo a la brevedad para explicarte los detalles que te interesen conocer en profundidad.</p>\r\n<p id="preg7"><strong>¿Qué sucede con mis datos al llenar el formulario de contacto?</strong></p>\r\n<p>Tus datos sólo se enviarán a las universidades o instituciones que sean de tu interés para que las mismas te contacten y puedan detallarte su plan de estudios. ZonaJobs Educación tiene como objetivo facilitar la interacción entre los estudiantes aplicantes y las instituciones educativas, y no interfiere en el proceso de contacto de estas últimas. </p>\r\n<p>Lee nuestros términos y condiciones para saber más. </p>\r\n<p id="preg8"><strong>¿Cómo hace una institución para contactarse conmigo?</strong></p>\r\n<p>Si has llenado correctamente tus datos de contacto, la institución te contactará por correo electrónico o por teléfono, según su preferencia. Te recordamos que ZonaJobs Educación sólo facilita la interacción entre los estudiantes aplicantes y las instituciones, y no interfiere en el proceso de contacto de las últimas.</p>\r\n<p id="preg9"><strong>Todavía no definí lo que quiero estudiar, ¿qué debo hacer?</strong></p>\r\n<p>Si todavía no encontraste tu verdadera pasión, te sugerimos realizar nuestro test vocacional online, haciendo clic aquí. El test no te llevará más de 5 minutos y te permitirá ver de una manera más clara el ámbito en el que puedes desempeñarte de manera efectiva. </p>\r\n<p id="preg10"><strong>Realicé el test vocacional pero tengo algunas dudas sobre el resultado, ¿qué puedo hacer?</strong></p>\r\n<p>Si tienes dudas sobre el resultado de tu test, puedes asesorarte con CATAIFE, Consultora de carrera, ingresando <a href="http://www.consultoradecarrera.com.ar/">aquí</a> o enviando un correo a info@consultoradecarrera.com.ar . Un especialista te asesorará por correo electrónico y podrás concretar una entrevista personal en caso de que lo desees.  </p>\r\n<p id="preg11"><strong>¿Qué es una carrera universitaria?</strong></p>\r\n<p>Una carrera o terciario se refiere al proceso en donde, después de haber cursado la educación secundaria o educación media, se estudia una carrera profesional y se obtiene una titulación superior. El requisito para ingresar es haber finalizado la educación secundaria y es común que exista una selección de los postulantes basados en el rendimiento escolar de la secundaria o exámenes de ingreso. Lee nuestras notas para saber más. </p>\r\n<p id="preg12"><strong>¿Por qué estudiar una carrera universitaria o un terciario? </strong></p>\r\n<ul class="bullets">\r\n<li>Te vuelves más capacitado y valorado en el mercado laboral. </li>\r\n<li>8 de cada 10 personas con título universitario se encuentran trabajando actualmente. </li>\r\n<li>El 82% de las búsquedas de las empresas en la base de candidatos de ZonaJobs son a personas con título universitario. </li>\r\n</ul>\r\n<p id="preg13"><strong>¿Qué es un posgrado?</strong></p>\r\n<p>Un posgrado comprende los títulos de maestría (también llamado máster) y doctorado. Estos son la última fase de la educación formal y tienen como antecedente obligatorio la titulación de grado, además tiene otros requisitos (como la experiencia laboral y la edad), que varían según la institución. Recomendamos realizar el posgrado en una institución distinta a la que has realizado tus estudios de grado. Lee nuestras notas para saber más.</p>\r\n<p id="preg14"><strong>¿Por qué debo estudiar un posgrado?</strong></p>\r\n<p>Sólo el 15% de los universitarios realizaron un posgrado, por lo que:</p>\r\n<ul class="bullets">\r\n<li>Te vuelves más valorado en el mercado laboral, ampliando tus capacidades de negociación frente a una empresa. </li>\r\n<li>8 de cada 10 personas que realizaron un posgrado tienen un puesto de alta jerarquía. </li>\r\n</ul>\r\n<p id="preg15"><strong>¿Qué es un curso?</strong></p>\r\n<p>Los cursos son muchos y muy variados. Generalmente se utilizan para capacitarse en un tema específico ya que son de corta duración. Si eliges un curso adecuado a tu carrera o profesión, se considerará un plus en tu CV. Lee nuestras notas para saber más.</p>\r\n<p id="preg16"><strong>¿Por qué debo estudiar un curso?</strong></p>\r\n<ul class="bullets">\r\n<li>Adquieres conocimientos útiles fáciles de aplicar a tu futuro empleo. </li>\r\n<li>Te vuelves más especializado. </li>\r\n<li>Te vuelves más competitivo y valorado en el mercado laboral. </li>\r\n</ul>\r\n<p id="preg17"><strong>Quiero realizar una consulta o sugerencia, ¿cómo lo hago?</strong></p>\r\n<p>Si tienes una duda o una sugerencia para realizar puedes llenar nuestro formulario de contacto haciendo clic aquí. En ZonaJobs Educación queremos seguir mejorando el servicio ofrecido, por lo tanto tu opinión es muy valiosa para nosotros. </p>\r\n<p id="preg18"><strong>Preguntas frecuentes para Instituciones Educativas</strong></p>\r\n<p><strong>¿Cómo funciona ZonaJobs Educación?</strong></p>\r\n<p>ZonaJobs Educación actúa como nexo entre las instituciones y los potenciales estudiantes, brindándoles una guía completa de todas las carreras, cursos y posgrados disponibles en su país. En caso de estar interesados, los usuarios completarán un formulario de datos para que usted pueda contactarse con ellos y explicarles los detalles de su oferta académica. </p>\r\n<p id="preg19"><strong>¿Cómo registro mi Institución?</strong></p>\r\n<p>Para anunciar su institución / universidad y figurar en el buscador de <strong>ZonaJobs Educación</strong>, haga clic aquí. Darse de alta en el sitio y publicar sus carreras, cursos y posgrados es <strong>totalmente gratuito</strong>. </p>\r\n<p>Una vez que complete nuestro formulario, un ejecutivo lo contactará para asesorarlo en el proceso de publicación. </p>\r\n<p id="preg20"><strong>¿Cómo publico un curso, carrera o posgrado?</strong></p>\r\n<p>Si ya está dado de alta, puede contactarse con su ejecutivo para que lo asesore con el proceso. Si aún no se registró, debe llenar el formulario de registro haciendo clic aquí. Una vez que complete el formulario, se le asignará un ejecutivo que lo asesorará con la publicación de sus ofertas educativas. </p>\r\n<p id="preg21"><strong>¿Qué tipo de instituciones pueden registrarse en ZonaJobs Educación?</strong></p>\r\n<p>En ZonaJobs Educación pueden registrarse todo tipo de instituciones educativas, ya sean universidades, terciarios, institutos, escuelas, talleres, academias, y todo aquel que quiera anunciar una oferta educativa de cualquier tipo. </p>\r\n<p id="preg22"><strong>¿Cómo destaco mi instituto? </strong></p>\r\n<p>Si quiere destacar su instituto, puede escribirnos a <a href="mailto:instituciones@zonajobs.com">instituciones@zonajobs.com</a>indicando su país. Uno de nuestros ejecutivos lo asesorará para que pueda llenar sus aulas de la manera más rápida y efectiva. </p>\r\n<p id="preg23"><strong>¿Puedo destacar una carrera específica?  </strong></p>\r\n<p>Si quiere destacar una carrera, curso o posgrado específico, puede escribirnos según su país:</p>\r\n<p>Argentina: <a href="mailto:instituciones@zonajobs.com">instituciones@zonajobs.com.ar</a><br /> Chile: <a href="mailto:instituciones@zonajobs.cl">instituciones@zonajobs.cl</a><br /> Colombia: <a href="mailto:instituciones@zonajobs.com.co">instituciones@zonajobs.com.co</a><br /> México: <a href="mailto:instituciones@zonajobs.com.mx">instituciones@zonajobs.com.mx</a><br /> Venezuela: <a href="mailto:instituciones@zonajobs.com.ve">instituciones@zonajobs.com.ve</a></p>\r\n<p>Uno de nuestros ejecutivos lo asesorará para que pueda llenar sus aulas de la manera más rápida y efectiva. </p>\r\n<p id="preg24"><strong>¿Cómo contacto a los interesados en mi institución?</strong></p>\r\n<p>Podrá contactar a los usuarios de manera telefónica o por correo electrónico, y otorgar una entrevista en caso de ser necesario. Le recordamos que ZonaJobs Educación tiene como objetivo facilitar la interacción entre los estudiantes aplicantes y las instituciones educativas, y no interfiere en el proceso de contacto ni en las entrevistas personales. </p>\r\n<p id="preg25"><strong>Quiero realizar una consulta o sugerencia a ZonaJobs Educación, ¿cómo puedo hacer?</strong></p>\r\n<p>Para contactarnos, puede escribirnos a <a href="mailto:instituciones@zonajobs.com">instituciones@zonajobs.com</a> detallando su país. Allí podrá reflejarnos sus dudas, inquietudes y sugerencias. En ZonaJobs Educación queremos seguir mejorando el servicio ofrecido, por lo tanto su opinión es muy valiosa para nosotros.</p>', NULL, NULL, '2013-02-26 18:57:50', 1, 'backend', '2014-07-01 11:40:02', 1, 'backend', '0000-00-00 00:00:00', 0, 0, 0, 0, 'a:3:{s:4:"tags";s:0:"";s:9:"metatitle";s:20:"Preguntas frecuentes";s:15:"metadescription";s:0:"";}'),
(173, 1, 0, 'Los posgrados, un pasaporte a los mejores puestos ejecutivos', 'los-posgrados-un-pasaporte-a-los-mejores-puestos-ejecutivos', '<p class="p1"><span class="s1">La oferta de estudios se amplía al ritmo de la evolución del mercado laboral</span></p>\r\n<p class="p2"><span class="s1">Tener o no tener un título de MBA puede ser un factor discriminante para un joven profesional que aspire a ocupar un puesto ejecutivo en alguna corporación importante, por lo que hoy son pocos los que pueden darse el lujo de no contar en su haber con una competencia semejante.</span></p>\r\n<p class="p2"><span class="s1">Felizmente, en la Argentina los jóvenes profesionales y también los profesionales jóvenes tienen a mano una creciente oferta de estudios de posgrado, aunque no todas las instituciones ofrecen programas rigurosamente aprobados por la Comisión Nacional de Evaluación y Acreditación Universitaria (Coneau). Durante la próxima feria de Consortium, que se realizará el 29 y 30 de este mes, algunas de las universidades más prestigiosas estarán presentes para informar a los visitantes sobre objetivos, metodologías y contenidos que mejor se ajusten a las expectativas personales. Incluso en la feria se realizará el Ciclo de Capacitación al Joven Profesional (las vacantes son limitadas, por más información comunicarse por el 5520-0004).</span></p>\r\n<p class="p2"><span class="s1">"Para nosotros, posgrado son todas aquellas actividades académicas que superan determinado número de horas, las que están aprobadas por la Coneau -afirma Luis Vergani, director de posgrados del ITBA-. Desde hace años en la Argentina esta legislado por ley el alcance de esta palabra con sus tres categorizaciones, que son especialización, maestría y doctorado. Es decir, no se puede utilizar livianamente."</span></p>\r\n<p class="p2"><span class="s1">Con una carga de 365 horas netas mínimas de clase presenciada, el ITBA cuenta hoy con 500 alumnos cursando posgrados y otros 700 en distintos programas de educación continua, donde el más demandado es el de Proyect Managment. Por tratarse de áreas específicas de la tecnología, la casa se reserva el derecho de admitir a los recién egresados de las carreras de grado.</span></p>\r\n<p class="p3"><span class="s1">"La mayoría de los estudiantes tienen más de 30 años. Creemos que para el grueso de nuestros cursos hace falta traer algún bagaje de experiencia aparte del estudio, es decir, no recibimos gente recién salida del grado, menos en temas enimentemente tecnológicos, que son los más numerosos y que combinan la tecnología, las finanzas, la comercialización y las clínicas de gestión. Pensamos que es imposible de cumplir esa promesa que algunos les hacen a los jóvenes, de que por ser un gran promedio una persona de 24 años puede cursar un MBA y a los 26 ya estar en el fast track", agrega Vergani. La evolución del mercado plantea nuevos desafíos y las universidades se ajustan a ellos a la hora de diseñar sus planes de estudios. El Departamento de Economía de la Universidad Torcuato Di Tella agregó a su menú dos programas de educación ejecutiva que antes de 2001 no existían: el de Econometría y el de Actualización en Economía Avanzada. Respecto de otras áreas de estudio, inauguró la maestría en Estudios Internacionales, el máster en Periodismo, el programa de Economía Urbana se convirtió en maestría y se lanzó el Programa Internacional de Derecho Tributario. Los estudiantes, por ejemplo, que cursan posgrados en finanzas son en su mayoría contadores y economistas egresados de la UBA cuyas edades rondan los 27 y 30 años. "Los más concurridos son los posgrados en negocios: MBA, Executive MBA y la Maestría en Finanzas -explica Karina Chrempacz, directora de Admisiones de Posgrado-. Seguramente se debe a que son los que tienen mayor salida laboral y repago de la inversión. El mercado lo pide. Aunque la persona no tenga muchas ganas de realizar un posgrado en estas áreas, sus trabajos lo requieren, o creen que cursando estos programas tendrán mejores oportunidades laborales, y económicas." En el caso de Ucema, durante la década del 90 amplió sus posgrados y en especial la maestría en Administración de Empresas se orientó a tres nuevas áreas: Mercado de Capitales, Finanzas Corporativas y Aspectos Legales de las Finanzas, que actualmente cursan cerca de 130 alumnos de más de 26 años y con experiencia laboral. "Estas reorientaciones fueron inauguradas en 1995 -explica Edgardo Zablostsky, director de la maestría en Finanzas-. En el caso de los abogados, necesitan conocimientos de finanzas, en especial si cumplen roles importantes en compañías financieras." </span></p>\r\n<p class="p4"> </p>\r\n<p class="p5"><span class="s2">Por: <a href="http://www.lanacion.com.ar/autor/marina-gambier-282"><span class="s3"><strong>Marina Gambier</strong></span></a></span><span class="s4"> </span></p>\r\n<p class="p6"><span class="s4">Fuente: <a href="http://www.lanacion.com.ar/"><span class="s5">La Nación</span></a></span></p>', '', '', '2013-02-18 17:47:22', 1, 'backend', '2013-11-04 21:25:49', 1, 'backend', '2013-11-04 21:25:52', 1, 1, 0, 0, 'a:3:{s:9:"metatitle";s:60:"Los posgrados, un pasaporte a los mejores puestos ejecutivos";s:15:"metadescription";s:42:"                                          ";s:6:"header";s:0:"";}');
INSERT INTO `object` (`object_id`, `object_typeid`, `object_parent`, `object_title`, `object_shorttitle`, `object_content`, `object_summary`, `object_tags`, `creation_date`, `creation_userid`, `creation_usertype`, `modification_date`, `modification_userid`, `modification_usertype`, `publication_date`, `publication_userid`, `object_state`, `site_id`, `location_id`, `object_custom`) VALUES
(161, 3, 0, 'Términos y condiciones Argentina', 'terminos-y-condiciones', '<p> <strong>1. CONDICIONES GENERALES Y ACEPTACIÓN.</strong></p>\r\n<p><span class="s1">Esta página establece las "Condiciones Generales" que regulan el uso de los contenidos y servicios que integran el sitio web _______________ (en adelante, el "Sitio Web"). Por favor, lea esta página atentamente. SI NO ACEPTA ESTAS CONDICIONES GENERALES, NO UTILICE ESTE SITIO WEB. CUALQUIER PERSONA QUE NO ACEPTE ESTAS CONDICIONES GENERALES, LAS CUALES TIENEN CARÁCTER OBLIGATORIO Y VINCULANTE, DEBERÁ ABSTENERSE DE UTILIZAR EL SITIO WEB Y/O LOS SERVICIOS OFRECIDOS.</span></p>\r\n<p class="p2"><span class="s1">Si el Usuario utiliza el Sitio Web, se entenderá que ha aceptado plenamente y sin reservas las Condiciones Generales que estén vigentes en el momento de acceso. Por lo tanto, el Usuario se obliga a cumplir con todas las disposiciones contenidas en estas Condiciones Generales, bajo las leyes aplicables, estatutos, reglamentos y regulaciones concernientes al uso del Sitio Web. DRIDCO S.A., titular del Sitio Web (en adelante,"DRIDCO") se reserva el derecho de revisar estas Condiciones Generales en cualquier momento, actualizando y/o modificando esta página.</span></p>\r\n<p class="p2"><span class="s1">Usted debería visitar esta página cada vez que acceda al Sitio Web para revisar las Condiciones Generales, puesto que las mismas son obligatorias y vinculantes. Los términos "Usted" y "Usuario" se emplean aquí para referirse a todos las personas físicas y/o jurídicas que por cualquier razón accedan al Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Asimismo, debido a que ciertos servicios y contenidos ofrecidos a los Usuarios a través del Sitio Web pueden contener normas específicas que reglamentan, complementan y/o modifiquen a las presentes Condiciones Generales (en adelante las “Condiciones Particulares”), se recomienda a los Usuarios tomar conocimiento específico de ellas antes de la utilización de dichos servicios.</span></p>\r\n<p class="p2"><span class="s1"><strong>2. ACCESO AL SITIO WEB. USO DEL MATERIAL.</strong></span></p>\r\n<p class="p2"><span class="s1"><strong>2.1. Acceso y utilización del Sitio Web. Autorización de uso de marca/logo.</strong></span></p>\r\n<p class="p2"><span class="s1">El acceso y utilización del Sitio Web no exige la previa suscripción o registro del Usuario. Sin perjuicio de ello, la utilización de algunos servicios que se ofrecen a través del Sitio Web requiere la suscripción o registro del Usuario y/o el pago de un precio, conforme se establece en las Condiciones Particulares aplicables al cada servicio.</span></p>\r\n<p class="p2"><span class="s1">Todo Usuario registrado autoriza expresamente a DRIDCO a incorporar en el Sitio Web, a exclusivo criterio de este último, el logo/marca de titularidad del Usuario que ha contratado al menos uno de los servicios provistos a través de dicho Sitio Web, con el único fin de referenciar a dicho Usuario como cliente del Sitio Web.</span></p>\r\n<p class="p2"><span class="s1"><strong>2.2. Utilización del Sitio Web.</strong></span></p>\r\n<p class="p2"><span class="s1">El Usuario se compromete a utilizar el Sitio Web de conformidad con la ley, estas Condiciones Generales, las Condiciones Particulares aplicables, así como con la moral y buenas costumbres generalmente aceptadas y el orden público.</span></p>\r\n<p class="p2"><span class="s1">El Usuario se obliga a abstenerse de utilizar el Sitio Web con fines o efectos ilícitos, contrarios a lo establecido en las Condiciones Generales, lesivos de los derechos e intereses de terceros, o que de cualquier forma puedan dañar, inutilizar, sobrecargar o deteriorar el Sitio Web o impedir la normal utilización  del Sitio Web por parte de los Usuarios.</span></p>\r\n<p class="p2"><span class="s1"><strong>2.3. Utilización del contenido del Sitio Web.</strong></span></p>\r\n<p class="p2"><span class="s1">DRIDCO le autoriza a visualizar y/o descargar (bajar) una única copia de los contenidos del Sitio Web y exclusivamente para su uso personal y no comercial. Los contenidos de este Sitio Web, tales como texto, gráficos, imágenes, logos, iconos de botón, software y cualquier otro material, todo lo cual designaremos como "el Contenido", están protegidos por la legislación sobre propiedad industrial e intelectual (Derechos de Autor, copyright, marcas registradas). Todo el Contenido es propiedad de DRIDCO y/o de cualquier otra sociedad vinculada, de sus proveedores de contenido o de sus clientes. La compilación (es decir, la recopilación, la disposición y el montaje) de todos los contenidos de este Sitio Web es de propiedad exclusiva de DRIDCO y/o de sus empresas vinculadas y está protegida por la legislación sobre propiedad industrial e intelectual de Argentina. El uso no autorizado del Contenido puede suponer la violación de la legislación sobre propiedad intelectual o industrial (derechos de autor, marca registrada, etc.) y de otras leyes aplicables.</span></p>\r\n<p class="p2"><span class="s1">Usted debe observar, en cualquier copia que haga del Contenido, todas las advertencias sobre derechos de autor, marca registrada, marca de servicio y otras relativas a los derechos de propiedad industrial o intelectual contenidas en el Contenido original. No podrá vender o modificar el Contenido o reproducirlo, exhibirlo, representarlo en público, distribuirlo, o hacer otro uso de este Contenido con fines comerciales o de difusión. Está prohibido el uso del Contenido en cualquier otro sitio de la web o en otro entorno de ordenadores interconectados para cualquier fin.</span></p>\r\n<p class="p2"><span class="s1">Usted no copiará ni adaptará el código HTML que DRIDCO ha creado para generar sus páginas. Dicho código se halla protegido también por los derechos de propiedad intelectual (copyright) de DRIDCO o de cualquier otra sociedad vinculada.</span></p>\r\n<p class="p2"><span class="s1"><strong>2.4. Uso permitido del Sitio</strong></span></p>\r\n<p class="p2"><span class="s2">Reglas generales</span><span class="s1">: No está permitido a los Usuarios utilizar el Sitio Web para transmitir, distribuir, almacenar o destruir material (a) violando las leyes o regulaciones vigentes, (b) de forma que infrinjan el derecho de autor, la marca registrada, el secreto comercial o cualquier otro derecho de propiedad intelectual o industrial de terceros o violando la confidencialidad, imagen pública o demás derechos personales de otras personas, o (c) que sea difamatorio, obsceno, amenazador, injurioso u ofensivo.</span></p>\r\n<p class="p2"><span class="s2">Reglas de Seguridad del Sitio Web</span><span class="s1">: Se prohíbe a los Usuarios violar o intentar violar la seguridad del Sitio Web, incluyendo pero no limitándose a: (a) acceder a datos que no estén destinados a tal usuario o entrar en un servidor o cuenta cuyo acceso no está autorizado al Usuario, (b) evaluar o probar la vulnerabilidad de un sistema o red, o violar las medidas de seguridad o identificación sin la adecuada autorización, (c) intentar impedir el servicio a cualquier Usuario, anfitrión o red, incluyendo sin limitación, mediante el envío de virus al Sitio Web, o mediante saturación, envíos masivos ("flooding"), "spamming", bombardeo de correo o bloqueos del sistema ("crashing"), (d) enviar correos no pedidos, incluyendo promociones y/o publicidad de productos o servicios, o (e) falsificar cualquier cabecera de paquete TCP/IP o cualquier parte de la información de la cabecera de cualquier correo electrónico o en mensajes de foros de debate.</span></p>\r\n<p class="p2"><span class="s1">Las violaciones de la seguridad del sistema o de la red pueden resultar en responsabilidades civiles o penales. DRIDCO investigará los casos en los que hubiera podido producirse tales violaciones y puede dirigirse a y cooperar con la autoridad competente para perseguir a los usuarios involucrados en tales violaciones.</span></p>\r\n<p class="p2"><span class="s1"><strong>2.5. Usos  prohibidos</strong></span></p>\r\n<p class="p2"><span class="s1">El Sitio Web sólo puede ser utilizado con propósitos legales por personas que estén buscando empleo e información referida a carreras profesionales y por empresas que busquen empleados. DRIDCO prohíbe específicamente cualquier uso del Sitio Web, y todos los Usuarios aceptan no utilizar el Sitio Web, para lo siguiente:</span></p>\r\n<p class="p2"><span class="s1">    * Anunciar datos biográficos incompletos, falsos o inexactos o datos que no correspondan con su auténtico curriculum personal (de una persona física viva que busca empleo para sí misma).</span></p>\r\n<p class="p2"><span class="s1">    * Registrar más de una cuenta correspondiente a un mismo usuario (persona física) con mismo D.N.I.</span></p>\r\n<p class="p2"><span class="s1">    * Anunciar cualquier franquicia, "Búsqueda de socios", agencias de representantes de distribución o ventas u otra oportunidad de negocio que requiera un desembolso inicial o un pago periódico por parte del empleado o que sólo retribuya comisiones (no un salario razonable), o exija el reclutamiento de otros socios, subdistribuidores o subagentes.</span></p>\r\n<p class="p2"><span class="s1">    * Borrar o revisar cualquier material anunciado por otra persona o entidad.</span></p>\r\n<p class="p2"><span class="s1">    * Usar cualquier mecanismo, software o rutina para impedir o intentar impedir el adecuado funcionamiento de este Sitio Web o cualquier actividad que se esté realizando en este Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">    * Realizar cualquier acción que imponga una carga desproporcionada o desmesurada sobre la infraestructura de este Sitio de la Web.</span></p>\r\n<p class="p2"><span class="s1">    * Si posee una contraseña que le permite acceder a un área no pública de este Sitio Web, se prohíbe revelar o compartir su contraseña con terceras personas o usar su contraseña para cualquier propósito no autorizado.</span></p>\r\n<p class="p2"><span class="s1">    * No obstante cualquier referencia en contrario que contengan estas Condiciones Generales, el uso o intento de uso de cualquier máquina, software, herramienta, agente u otro mecanismo o artilugio (incluyendo pero no limitándose a exploradores, spiders, robots, avatars o agentes inteligentes) para navegar o buscar en este Sitio Web que sean diferentes a las máquinas de buscar o los agentes buscadores puestos a disposición por DRIDCO en este Sitio Web y diferentes de los exploradores web generalmente disponibles (ej. Netscape Navigator, Microsoft Explorer).</span></p>\r\n<p class="p2"><span class="s1">    * Intentar descifrar, descompilar u obtener el código fuente de cualquier programa de software que comprenda o constituya una parte de este Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">     * Publicar avisos que contengan datos personales (teléfono, domicilio, dirección del sitio web, correo electrónico, etc.) del oferente de empleo.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO se reserva el derecho de dar de baja cualquier anuncio publicado que no cumpla con los estándares definidos en estas Condiciones Generales o con las políticas vigentes de DRIDCO (incluídas las Condiciones Particulares de cualquier servicio provisto por DRIDCO), sin que ello genere derecho a resarcimiento alguno. Idéntico derecho le cabrá a DRIDCO para suspender o dar de baja del sistema de DRIDCO a cualquier Usuario por haber incumplido estas Condiciones Generales o  por haber incurrido a criterio de DRIDCO en conductas o actos dolosos o fraudulentos mediante el uso del Sitio Web o de los Servicios prestados por DRIDCO.</span></p>\r\n<p class="p2"><span class="s1"><strong>3. DATOS PERSONALES DEL USUARIO. REGISTRO EN EL SITIO WEB. </strong></span></p>\r\n<p class="p2"><span class="s1"><strong>3.1. Registración en el Sitio Web</strong></span></p>\r\n<p class="p2"><span class="s1">Cuando se registre en el Sitio Web, se le pedirá que aporte a DRIDCO cierta información que incluirá, entre otras, una dirección válida de correo electrónico (lo que designaremos como su "Información"). Además de los términos y condiciones que se puedan establecer más adelante por cualquier política de privacidad de este Sitio Web, Usted reconoce y acepta que DRIDCO puede revelar a terceras partes, de forma anónima, cierto conjunto de datos que estén contenidos en su solicitud de registro.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO  no revelará a terceras partes su nombre, dirección de correo electrónico o el número de teléfono sin su consentimiento previo, excepto en la medida en que sea necesario para el cumplimiento de las leyes o procedimientos legales vigentes, donde tal información sea relevante. DRIDCO se reserva el derecho de ofrecerle servicios y productos de terceros basados en las preferencias que Usted indicó al momento de registrarse o en cualquier momento posterior; tales ofertas pueden efectuarse por DRIDCO o por terceros. Por favor consulte la Política de Confidencialidad  y Cookies del Sitio Web para más detalles respecto a su Información.</span></p>\r\n<p class="p2"><span class="s1">Usted es el responsable de mantener la confidencialidad de sus datos y de su contraseña. El Usuario será responsable de todos los usos de su registro, tanto si están autorizados o no por Usted. Deberá notificar inmediatamente a DRIDCO sobre cualquier uso sin autorización de su registro o contraseña.</span></p>\r\n<p class="p2"><span class="s1"><strong>4. OBLIGACIONES DEL USUARIO.</strong></span></p>\r\n<p class="p2"><span class="s1">Como Usuario, Usted es responsable de sus propias comunicaciones y de las consecuencias de su publicación. Por el hecho de usar este Sitio Web, Usted acepta no realizar ninguna de las siguientes acciones: anunciar material con derechos de autor o cualquier otro derecho de propiedad intelectual o industrial a menos que Usted sea el propietario de estos derechos o tenga permiso del propietario de los citados derechos para anunciarlo; anunciar material que revele secretos comerciales a menos que sean de su propiedad o tenga permiso del propietario; anunciar material que infrinja los derechos de propiedad intelectual o industrial de terceros, o los derechos de confidencialidad o imagen de terceros; anunciar material que sea obsceno, difamatorio, amenazador, acosador, injurioso o denigrante hacia otro Usuario, o hacia cualquier persona o entidad; anunciar una imagen o declaración sexualmente explícita; anunciar propaganda o propuestas de negocio, anunciar cartas en cadena; suplantar a otra persona; o enviar material que contenga virus, caballos de Troya, gusanos ("worms"), bombas de tiempo, "cancelbots" u otras rutinas de programación que tengan por objeto dañar, interferir negativamente, interceptar secretamente, o apropiarse de cualquier sistema, datos o información.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO no afirma ni garantiza la licitud, exactitud o fiabilidad de las comunicaciones que anuncian los Usuarios ni respalda cualquier opinión expresada por los Usuarios. El Usuario acepta implícitamente que, al confiar en los contenidos o los datos anunciados por otros Usuarios, lo hace bajo su propia responsabilidad.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO actúa como un mero conductor pasivo para la distribución y publicación on-line de la información remitida por el Usuario y no está obligada a censurar las comunicaciones o datos con carácter previo, y no tiene la obligación ni se responsabiliza de revisar o censurar el material una vez que haya sido anunciado éste por los Usuarios.</span></p>\r\n<p class="p2"><span class="s1">En caso que un Usuario le notifique la existencia de comunicaciones que presuntamente no cumplan estas Condiciones Generales, DRIDCO se reserva el derecho de investigar y determinar de buena fe y, a su exclusiva discreción, el derecho de retirar o solicitar que sean retiradas dichas comunicaciones.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO no tiene responsabilidad u obligación hacia los Usuarios de realizar o no tales actividades de control. DRIDCO se reserva el derecho de impedir el acceso de los Usuarios al Sitio Web por violar las Condiciones Generales o la ley o las Condiciones Particulares, y se reserva el derecho de suprimir comunicaciones que sean injuriosas, ilegales o contrarias a la buena moral y costumbres. DRIDCO, a su sola discreción, puede tomar las medidas que considere necesarias o convenientes respecto a los datos remitidos por Usuarios, si estima que pueden hacer incurrir a DRIDCO en responsabilidades o pueden provocar que DRIDCO pierda (total o parcialmente) los servicios de sus ISPs u otros proveedores.</span></p>\r\n<p class="p2"><span class="s1">Al remitir un contenido a cualquier área pública o no del Sitio Web, incluyendo tablones de anuncios, foros, salas de discusión y chats, el Usuario concede a DRIDCO  y a sus empresas vinculadas  el derecho gratuito, perpetuo, irrevocable, cedible (a cualquier tercero) y no exclusivo, (incluyendo todos los derechos morales), y la licencia para usar, reproducir, modificar, adaptar, publicar, traducir, distribuir, comunicar al público, representar o exhibir tal contenido (total o parcialmente) a escala mundial, así como el derecho a incorporarlo a otros trabajos en cualquier formato, medio de difusión, o soporte tecnológico existente o de desarrollo futuro, durante todo el plazo de vigencia de los derechos que puedan existir sobre tal contenido. Usted también garantiza que el propietario de cualesquiera derechos en dicho contenido, incluidos los derechos morales, ha renunciado completa y efectivamente a tales derechos y le ha concedido válida e irrevocablemente a Usted el derecho de ceder la licencia arriba citada así como el derecho a autorizar todos los usos mencionados. Asimismo, Usted permite a cualquier otro Usuario a acceder, exhibir, examinar, almacenar y reproducir tal contenido para su uso personal. Sujeto a las condiciones previstas anteriormente, el propietario de tal contenido colocado en el Sitio Web retiene todos y cada uno de los derechos que pudieran existir sobre ese contenido.</span></p>\r\n<p class="p2"><span class="s1"><strong>5. UTILIZACIÓN DEL SITIO WEB, DE LOS SERVICIOS Y DE LOS CONTENIDOS BAJO LA EXCLUSIVA RESPONSABILIDAD DEL USUARIO.</strong></span></p>\r\n<p class="p2"><span class="s1">El Usuario acepta voluntariamente que el uso del Sitio Web, de sus servicios y de los Contenidos tiene lugar, en todo caso, bajo su única y exclusiva responsabilidad.</span></p>\r\n<p class="p2"><span class="s1"><strong>6. EXCLUSIÓN DE GARANTÍAS Y DE RESPONSABILIDAD.</strong></span></p>\r\n<p class="p2"><span class="s1">El Sitio Web es exclusivamente un lugar de encuentro. El Sitio Web actúa como un punto de reunión entre instituciones educativas que anuncian ofertas y usuarios que buscan información y no investiga ni censura las ofertas. DRIDCO no interviene en la transacción entre las instituciones educativas y los usuarios. Por ello, DRIDCO carece de control sobre la calidad, seguridad o legalidad de las ofertas educativas que se anuncian, sobre la veracidad de las ofertas.</span></p>\r\n<p class="p2"><span class="s1">Asimismo, se advierte sobre cualquier riesgo, incluidos a título enunciativo, el de daño físico, de tratar con extraños, con personas de nacionalidad extranjera, con personas menores de edad o con personas que actúan fraudulentamente. El Usuario asume todos los riesgos asociados con el trato con otros Usuarios con los que entre en contacto a través del Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Debido a las dificultades en Internet para comprobar la autenticidad del Usuario, el Sitio Web no puede confirmar que cada Usuario es quien dice ser. Como no podemos intervenir en las relaciones entre Usuarios ni controlar el comportamiento de los participantes en el Sitio Web, en el caso de que Usted tenga un enfrentamiento con uno o más Usuarios, usted exonera a DRIDCO y a todas las sociedades vinculadas y asociadas (y a sus directores, representantes y empleados) de cualquier responsabilidad derivada de acciones, demandas o indemnizaciones por daños de cualquier clase o naturaleza, que sean resultado de, o tengan conexión alguna con, dichos enfrentamientos.</span></p>\r\n<p class="p2"><span class="s1">No se controla la información suministrada por otros Usuarios que se pone a su disposición en este Sitio Web. Por su propia naturaleza, la información de otras personas puede ser de índole ofensiva, perjudicial o inexacta, y en algunos casos puede estar mal identificada o identificada fraudulentamente. Le recomendamos que tenga precaución y sentido común cuando use este Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">El Contenido puede contener imprecisiones o errores tipográficos. DRIDCO no asume compromisos respecto a la exactitud, la veracidad, la exhaustividad o la actualidad del Sitio Web o del Contenido. Los riesgos del uso del Sitio Web y del Contenido  corren por exclusiva cuenta y riesgo de Usted. Los cambios en el Sitio Web se harán de forma periódica y en cualquier momento.</span></p>\r\n<p class="p2"><span class="s1">El Usuario admite y acepta que es el único responsable de la forma, el contenido y la exactitud de cualquier curriculum que coloque en el Sitio Web. Los empleadores son los únicos responsables de sus anuncios en el Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">En ningún supuesto, DRIDCO puede considerarse oferente de empleo en relación con el uso que Usted haga del Sitio Web. Ni DRIDCO ni ninguna sociedad vinculada, será responsable de ninguna decisión de selección, cualquiera que sea la razón que la fundamente, hecha por cualquier entidad que ofrezca empleo en el Sito Web.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO no garantiza la disponibilidad y continuidad del funcionamiento del Sitio Web y de los servicios ofrecidos. No todos los servicios y Contenidos en general se encuentran disponibles para todas las áreas geográficas. Asimismo, DRIDCO no garantiza la utilidad del Sitio Web y de los Servicios para la realización de ninguna actividad en particular, ni su infalibilidad y, en particular, aunque no de modo exclusivo, que los Usuarios puedan efectivamente utilizar el Sitio Web, acceder a las distintas páginas web que forman el Sitio Web o a aquéllas desde las que se prestan los Servicios.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO no garantiza la privacidad y seguridad de la utilización del Sitio Web y de los Servicios y, en particular, no garantiza que terceros no autorizados no puedan tener conocimiento de la clase, condiciones, características y circunstancias del uso que los Usuarios hacen del Sitio Web, de los Contenidos y de los Servicios.</span></p>\r\n<p class="p2"><span class="s1">Ni DRIDCO ni ninguna de las sociedades vinculadas garantizan que el Sitio Web funcionará libre de errores o que el Sitio Web y su servidor estén libres de los virus informáticos u otros mecanismos lesivos. Si por el uso del Sitio Web tiene que acudir al servicio técnico o reponer el equipo o datos, ni DRIDCO ni ninguna de las sociedades vinculadas será responsable de estos gastos.</span></p>\r\n<p class="p2"><span class="s1">El Sitio Web y el Contenido se suministran tal como están, sin garantías de ninguna clase. Ni DRIDCO ni ninguna de las sociedades vinculadas asumen ningún tipo de garantía, tanto explícita como implícita, incluyendo la garantía de aptitud para el comercio, aptitud para propósitos concretos y de no infracción de derechos de terceros, todo ello con la mayor amplitud legal.</span></p>\r\n<p class="p2"><span class="s1">Ni DRIDCO ni ninguna de las sociedades vinculadas asumen garantías sobre la exactitud, la veracidad, la exhaustividad o la actualización de los contenidos, los servicios, el software, los textos, los gráficos y los vínculos.</span></p>\r\n<p class="p2"><span class="s1">En ningún caso DRIDCO, las sociedades vinculadas, sus proveedores o terceros mencionados en el Sitio Web serán responsables de cualquier daño incluyendo pero no limitándose a, daños incidentales y derivados, lucro cesante, o daños resultantes de la pérdida de datos o interrupción del negocio, que resulten del uso o de la imposibilidad de uso del Sitio Web y del material, tanto si se fundamentan en una supuesta garantía, responsabilidad contractual o extracontractual, o cualquier otro argumento legal, independientemente de que DRIDCO, las sociedades vinculadas, sus proveedores o terceros hayan sido advertidos o no de la posibilidad de tales daños.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO excluye cualquier responsabilidad por los daños y perjuicios de toda naturaleza que puedan deberse a la falta de disponibilidad o de continuidad del funcionamiento del Sitio Web y de los Servicios, a la defraudación de la utilidad que los Usuarios hubieren podido atribuir al Sitio Web y a los Servicios, a la falibilidad del Sitio Web y de los Servicios, y en particular, aunque no de modo exclusivo, a los fallos en el acceso a las distintas páginas web del Sitio Web o a aquéllas desde las que se prestan los Servicios.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO excluye toda responsabilidad por los daños y perjuicios de toda naturaleza que pudieran deberse al conocimiento que puedan tener terceros no autorizados de la clase, condiciones, características y circunstancias del uso que los Usuarios hacen del Sitio Web, de los Contenidos y de los Servicios.</span></p>\r\n<p class="p2"><span class="s1"><strong>7. VÍNCULOS A OTROS SITIOS.</strong></span></p>\r\n<p class="p2"><span class="s1">El Sitio Web contiene vínculos a otros sitios de la web. Estos vínculos los proporciona DRIDCO únicamente para su comodidad y no significan un respaldo a los contenidos de estos sitios web. DRIDCO no es responsable del contenido de los sitios web vinculados de terceros y no hace ninguna afirmación relativa al contenido o su exactitud en estos sitios web de terceros. Si Usted decide acceder a sitios web de terceras partes vinculados, lo hace a su propio riesgo.</span></p>\r\n<p class="p2"><span class="s1">El Sitio Web adoptará las medidas o procedimientos oportunos para suprimir o inutilizar aquellos enlaces de los que tenga un conocimiento efectivo de que la actividad o información a la que remiten o recomiendan es ilícita o lesiona bienes o derechos de terceros susceptibles de indemnización.</span></p>\r\n<p class="p2"><span class="s1"><strong>8. CESIÓN O USO COMERCIAL NO AUTORIZADO.</strong></span></p>\r\n<p class="p2"><span class="s1">Usted acepta no ceder, bajo ningún título, sus derechos u obligaciones bajo estas Condiciones Generales. Usted también acepta no realizar ningún uso comercial no autorizado del Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Asimismo, el Usuario se compromete a utilizar el Sitio Web, el Contenido y los Servicios de conformidad con la ley, estas Condiciones Generales y –en su caso– las Condiciones Particulares, así como de forma correcta y diligente.</span></p>\r\n<p class="p2"><span class="s1"><strong>9.  CANCELACIÓN.</strong></span></p>\r\n<p class="p2"><span class="s1">DRIDCO se reserva el derecho, a su total discreción, de emplear todos los medios legales a su alcance, -incluyendo pero no limitándose a la supresión de sus anuncios de este Sitio Web y a la inmediata cancelación de su registro, imposibilitándole el acceso al Sitio Web y/o cualquier otro servicio que le haya proporcionado a DRIDCO-, en caso que Usted infrinja cualquiera de estas Condiciones Generales o si DRIDCO es incapaz de verificar la autenticidad de cualquier información que Usted haya enviado al registro del Sitio Web.</span></p>\r\n<p class="p2"><span class="s1"><strong>10. INDEMNIZACIÓN.</strong></span></p>\r\n<p class="p2"><span class="s1">Usted acepta defender, indemnizar y mantener indemnes a DRIDCO, las sociedades vinculadas, sus directivos, empleados y representantes, de y contra cualquier cargo, acción o demanda, incluyendo, pero no limitándose a, los gastos legales razonable, que resulten del uso que Usted haga del Sitio Web, de los Contenidos y de los Servicios, o bien de la infracción por su parte de estas Condiciones Generales y, en su caso, de las Condiciones Particulares. DRIDCO le notificará puntualmente de cualquier demanda, acción o proceso y le asistirá, a su costa, en su defensa contra cualquier demanda, acción o proceso de esta naturaleza.</span></p>\r\n<p class="p2"><span class="s1"><strong>11. GENERAL.</strong></span></p>\r\n<p class="p2"><span class="s1">DRIDCO no asegura que los Contenidos puedan ser visualizados o descargados legítimamente fuera de Argentina. El acceso a los Contenidos por ciertas personas o en ciertos países puede ser ilegal. Si Usted accede al Sitio Web fuera de Argentina, lo hace bajo su propia responsabilidad y es responsable de cumplir las leyes de su jurisdicción.</span></p>\r\n<p class="p2"><span class="s1">Estas Condiciones Generales se rigen por las leyes de la Republica Argentina. Cualesquiera demanda derivada de estas Condiciones Generales se someterá exclusivamente a la jurisdicción de los juzgados y tribunales de la Ciudad de Buenos Aires (Argentina), salvo que por imperativo legal sean competentes los juzgados y tribunales del domicilio del Usuario, en cuyo caso prevalecerá este fuero. Si cualquier cláusula de estas Condiciones Generales se declarase nula por cualquier órgano jurisdiccional competente, la nulidad de tal cláusula no afectará a la validez de las restantes cláusulas de estas Condiciones Generales, que mantendrán su plena vigencia y efecto. Ninguna renuncia a cualquier cláusula contenida en estas Condiciones Generales será considerada como una renuncia continuada de dicha cláusula o cualquier otra cláusula.</span></p>\r\n<p class="p2"><span class="s1">Con la excepción de las estipulaciones adicionales que se expliciten en otras áreas del Sitio Web, de determinadas "Advertencias legales", de las Licencias del Software o material en determinadas páginas web, o de las Condiciones Particulares que Usted haya acordado con DRIDCO, estas Condiciones Generales constituyen la totalidad del acuerdo entre usted y DRIDCO con respecto al uso del Sitio Web. Cualquier cambio de estas Condiciones Generales requiere la colocación de un texto revisado en esta página web.</span></p>\r\n<p class="p2"><span class="s1"><strong>12. DURACIÓN Y TERMINACIÓN.</strong></span></p>\r\n<p class="p2"><span class="s1">La prestación del servicio de Sitio Web y de los demás Contenidos y Servicios tiene, en principio, una duración indefinida. No obstante ello, DRIDCO está autorizada para dar por terminada o suspender la prestación del servicio del Sitio Web y/o de cualquiera de los Contenidos y Servicios en cualquier momento, sin perjuicio de lo que se hubiere dispuesto al respecto en las correspondientes Condiciones Particulares. Cuando ello sea razonablemente posible, DRIDCO comunicará previamente la terminación o suspensión de la prestación del servicio del Sitio Web y de los demás Servicios.</span></p>\r\n<p class="p2"><span class="s1"><strong>13. TÉRMINOS DE USO ADICIONALES.</strong></span></p>\r\n<p class="p2"><span class="s1">Ciertas áreas de este Sitio Web están sujetas a términos y condiciones de uso adicionales. Al usar estas áreas, o cualquier parte de ellas, Usted acepta cumplir los términos adicionales aplicables a dichas áreas.</span></p>\r\n<p class="p3"><span class="s1">Condiciones Generales actualizados al _______________</span></p>\r\n<p class="p4"><span class="s1">COMPROMISO DE PRIVACIDAD</span></p>\r\n<p class="p2"><span class="s1"><strong>Aspectos generales</strong></span></p>\r\n<p class="p2"><span class="s1">El Compromiso de Privacidad del Sitio Web <a href="http://www.expozonajobs.com"><span class="s3">__________________</span></a> se regirá por el establecido para el Sitio <a href="http://www.zonajobs.com"><span class="s3">___________________</span></a>, que a continuación se transcribe.</span></p>\r\n<p class="p2"><span class="s1">El sitio web ______________ (el “Sitio Web”) es operado por DRIDCO S.A. según se describe a continuación.</span></p>\r\n<p class="p2"><span class="s1">Dridco se compromete a proteger la privacidad de los usuarios del Sitio Web. Se procura ofrecer a los usuarios una experiencia on-line segura y con garantías. El objetivo del presente Compromiso es informar a los usuarios cómo utilizaremos los datos personales que nos facilite a través de este Sitio Web, sin que sea aplicable a información que obtengamos de cualquier otro modo. Este Compromiso se dirige a demandantes de empleo y empresas.</span></p>\r\n<p class="p2"><span class="s1">Dridco cumple la legislación sobre protección de datos. Esa legislación regula el tratamiento de información relativa a usted y le concede diversos derechos respecto de sus datos personales.</span></p>\r\n<p class="p2"><span class="s1">El Sitio Web contiene enlaces a otros sitios web sobre los que Dridco no tiene ningún control. Dridco no es responsable de las políticas o prácticas sobre privacidad de otros sitios web con los que usted elija enlazarse desde el Sitio Web. Le recomendamos que revise las políticas de privacidad de esos otros sitios web para que pueda ponerse al corriente de cómo recogen, usan y comparten sus datos. Este Compromiso de Privacidad se aplica exclusivamente a la información que Dridco obtenga en este el Sitio Web, sin que sea aplicable a información que Dridco obtenga de cualquier otro modo.</span></p>\r\n<p class="p2"><span class="s1"><strong>Obtención y retención de información</strong></span></p>\r\n<p class="p2"><span class="s1">Usted no tiene que darnos ninguna información personal con objeto de realizar búsquedas de empleo.</span></p>\r\n<p class="p2"><span class="s1">En algunas áreas del Sitio Web, Dridco requiere que usted facilite datos personales, incluido su nombre, dirección, dirección de correo electrónico, número de teléfono, información de contacto, información para facturación y otros datos de los que se pueda deducir su identidad. En otras áreas del Sitio Web, Dridco recoge o puede recoger información demográfica que no es exclusiva de usted, como su código postal, edad, género y los tipos de empleo en que esté interesado. En ocasiones Dridco recoge o se puede recoger una combinación de los dos tipos de información.</span></p>\r\n<p class="p2"><span class="s1">Además, Dridco podrá recoger indirectamente información sobre usted cuando use ciertos servicios de terceros en el Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Asimismo, Dridco obtiene o puede obtener cierta información personal sobre el uso que hace del Sitio Web, como por ejemplo a qué páginas accede y qué servicios utiliza. Además, hay información sobre el hardware y software de su computadora que es o puede ser recogida por Dridco. Esta información puede incluir su dirección IP, tipo de navegador, nombres de dominio, horas de acceso y referencias a direcciones de sitios web, si bien esta información no queda vinculada a sus datos personales.</span></p>\r\n<p class="p2"><span class="s1">En ocasiones Dridco puede ofrecer al usuario la oportunidad de dar sobre sí mismo información descriptiva, cultural o de su conducta, preferencias y/o estilo de vida, pero depende exclusivamente de usted que aporte esa información. Si da esa información, consiente con ello al uso de la misma de acuerdo con las políticas y prácticas descritas en este Compromiso de Privacidad. Por ejemplo, esa información podrá ser usada a efectos de determinar su interés potencial en recibir correo electrónico u otras comunicaciones sobre determinados productos o servicios.</span></p>\r\n<p class="p2"><span class="s1"><strong>Divulgación en áreas públicas de Dridco</strong></span></p>\r\n<p class="p2"><span class="s1">Recuerde que si divulga cualquiera de sus datos personales en áreas públicas del Sitio Web, como la base de datos de Curriculum con acceso en búsquedas, esa información podrá ser examinada y usada por otros sobre los que Dridco no tiene control alguno. No somos responsables del uso por terceras personas de información que usted difunda o haga disponible de otra forma en áreas públicas de Dridco.</span></p>\r\n<p class="p2"><span class="s1"><strong>Uso de sus datos por Dridco</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco utiliza los datos que obtiene en el Sitio Web, ya sean personales, demográficos, colectivos o técnicos, para los fines de administrar y gestionar su registro, responder a cualesquiera consultas que usted haga, operar y mejorar el Sitio Web y entregar los productos y servicios que ofrece Dridco a demandantes de empleo y empresas.</span></p>\r\n<p class="p2"><span class="s1">Si usted así lo ha aceptado al registrarse en el Sitio Web o posteriormente, o si es permitido por las leyes aplicables, podemos usar su información de contacto para enviarle correo electrónico u otras comunicaciones relativas a actualizaciones en el Sitio Web. Además, en el momento del registro usted tiene la opción de elegir la recepción de comunicaciones, información y promociones adicionales, relativas a temas que puedan ser de especial interés para usted. Si ha dado su consentimiento o si es permitido por las leyes aplicables, también podemos usar la información que obtengamos para informarle de otros productos o servicios disponibles en el Sitio Web  o para ponernos en contacto con usted con el fin de recabar su opinión sobre productos y servicios actuales o nuevos productos y servicios potenciales que le puedan ser ofrecidos.</span></p>\r\n<p class="p2"><span class="s1">En el Sitio Web existe un área donde usted puede ponerse en contacto con Dridco y remitir sus comentarios. Dridco podrá utilizar esos comentarios (como una experiencia exitosa) para fines de promoción o para ponernos en contacto con usted con objeto de obtener información adicional.</span></p>\r\n<p class="p2"><span class="s1"><strong>Revelación de información a terceros</strong></span></p>\r\n<p class="p2"><span class="s1">No revelamos a terceros sus datos personales, información personal y demográfica combinada o información sobre su uso del Sitio web (como las áreas que visita o los servicios a los que accede), excepto en los supuestos siguientes.</span></p>\r\n<p class="p2"><span class="s1">1. Podemos revelar esa información a terceros si usted da su consentimiento.</span></p>\r\n<p class="p2"><span class="s1">2. Podemos revelar esa información a empresas y personas físicas que empleemos para desempeñar funciones en nuestro nombre. Las funciones desempeñadas en nuestro nombre incluyen hosting en nuestros servidores de red, análisis de datos, prestación de asistencia de marketing, procesamiento de pagos por tarjeta de crédito y prestación de servicios a clientes. Estas empresas y personas tendrán acceso a sus datos personales en la medida que sea necesaria para desempeñar sus funciones, pero no podrán compartir esa información con ningún tercero o usar esos datos para ningún otro objeto. Nosotros retendremos el control de cualquier información compartida de esta forma y seremos responsables de dicha información.</span></p>\r\n<p class="p2"><span class="s1">3. Podemos revelar esa información si fuera legalmente requerido hacerlo, si fuera solicitado por una entidad oficial o autoridad reguladora o si estimamos de buena fe que esa acción es necesaria para: (a) ajustarnos a requisitos legales o cumplir un proceso legal; (b) proteger los derechos o bienes de Dridco o de sus sociedades vinculadas; (c) prevenir un delito o proteger la seguridad nacional, o (d) proteger la seguridad personal de los usuarios o del público.</span></p>\r\n<p class="p2"><span class="s1">4. Podemos revelar y transmitir esa información a un tercero que adquiera la totalidad o una parte sustancial del negocio de Dridco, independientemente de que dicha adquisición sea por vía de fusión, consolidación o compra de la totalidad o una parte sustancial de sus activos. Además, en el caso de que Dridco sea objeto de un procedimiento de insolvencia, voluntario o involuntario, Dridco o su liquidador, administrador, interventor o interventor administrativo podrá vender, conceder licencia al respecto o disponer de otro modo de esa información en una operación aprobada por un tribunal. Será usted informado de la venta de la totalidad o una parte sustancial de nuestro negocio a un tercero por medio del correo electrónico o a través de un anuncio destacado publicado en el sitio de Dridco.</span></p>\r\n<p class="p2"><span class="s1"><strong>Otros usos de información</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco también podrá compartir información anónima colectiva sobre visitantes al Sitio Web con sus clientes, socios y otras terceras partes a fin de que puedan estar al corriente de las clases de visitantes del sitio de Dridco y de cómo esos visitantes usan el sitio.</span></p>\r\n<p class="p2"><span class="s1">Curriculums y sus datos personales serán almacenados y procesados en ordenadores situados en los Estados Unidos según más abajo se describe. Por otro lado, algunas de las empresas o agencias de empleo que se interesen por su Curriculum podrán estar situadas en cualquier país del mundo. Esos países podrán no tener una legislación equivalente sobre protección de datos que proteja el uso de sus datos personales. No enviaremos sus datos personales a empresas de dichos países a menos que usted haya indicado que desea que se acceda a su Curriculum mediante búsquedas (Privacidad: Público). Mediante esta indicación, usted da su consentimiento expreso a que se realicen esas transferencias de datos.</span></p>\r\n<p class="p2"><span class="s1"><strong>Uso de web beacons</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco pueden contener imágenes electrónicas conocidas como "web beacons" (algunas veces denominadas "single-pixel gifs") que nos permiten contar los usuarios que han visitado el Sitio Web. Los web beacons no se usan para acceder a su información personal identificable que se almacena en Dridco; constituyen una técnica que usamos para confeccionar estadísticas de forma colectiva sobre el uso de nuestro Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Los web beacons recogen solamente un conjunto limitado de datos, incluido un número de cookie, la hora y fecha de visita a un sitio y una descripción del sitio en que reside el web beacon.</span></p>\r\n<p class="p2"><span class="s1">Dado que los web beacons son como cualquier otra petición de contenidos incluidos en una página, usted no puede desactivarlos o rechazarlos. Sin embargo, puede hacer que no sean efectivos desactivando las cookies o cambiando la configuración de cookies en su navegador.</span></p>\r\n<p class="p2"><span class="s1"><strong>Actualización o supresión de sus datos</strong></span></p>\r\n<p class="p2"><span class="s1">Usted puede revisar, corregir, actualizar o cambiar sus datos personales de la cuenta de Registro o su Curriculum en cualquier momento. Simplemente acceda a su cuenta de Registro, vaya a su perfil de la cuenta o su Curriculum, revise sus datos de la cuenta o Curriculum y, si lo desea, edítelos con las opciones que se facilitan. También podrá suprimir su Curriculum mediante este método.</span></p>\r\n<p class="p2"><span class="s1">Si en cualquier momento desea suprimir su información de datos personales de la cuenta de Registro, póngase en contacto con Dridco a través del formulario “Contactanos” al cual se puede acceder desde el link situados en el margen superior derecho de todas las páginas disponibles en el sitio.</span></p>\r\n<p class="p2"><span class="s1">Si desea revocar su consentimiento a nuestro Compromiso de Privacidad, póngase en contacto con nosotros a través del formulario “Contactanos” al cual se puede acceder desde el link situados en el margen superior derecho de todas las páginas disponibles en el sitio. Sin embargo, tenga en cuenta que si retira su consentimiento, no podrá usar los servicios correspondientes y serán suprimidos sus datos personales de la cuenta de registro de Dridco.</span></p>\r\n<p class="p2"><span class="s1">Si optó por recibir Newsletters, correos electrónicos comerciales u otras comunicaciones de Dridco o de terceras partes en el momento de registrarse, pero posteriormente cambia de opinión, podrá anular su opción editando su perfil de cuenta según lo arriba descrito. Si previamente optó por no recibir esas comunicaciones, podrá posteriormente anular esa opción editando su perfil de cuenta.</span></p>\r\n<p class="p2"><span class="s1">Como creemos que gestionar su promoción profesional es un proceso que dura toda la vida, conservamos toda la información que recabamos sobre usted con el fin de que el uso repetido de nuestros servicios se produzca de forma eficiente, práctica y relevante hasta que cambie o retire sus datos personales según lo arriba indicado anteriormente. Si es usted un demandante de empleo y no ha accedido al sitio web durante 9 meses, automáticamente hacemos que su Curriculum no sea accesible en búsquedas. Por supuesto, puede corregir o actualizar su perfil y su Curriculum en cualquier momento. Además, puede suprimir su Curriculum de la base de datos on-line de Dridco cuando lo desee. Si lo hace, retiraremos todas nuestras copias de su Curriculum.</span></p>\r\n<p class="p2"><span class="s1"><strong>Seguridad</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco ha implementado medidas apropiadas de carácter técnico y organizativo que están diseñadas para garantizar la seguridad de su información personal frente a pérdidas accidentales y frente al acceso, uso, alteración o divulgación no autorizados. En particular, todos los datos de la cuenta y de la clave de acceso están encriptados (es decir, se codifican entre su computadora y los servidores de Dridco). Pese a estas medidas, Internet es un sistema abierto y no podemos garantizar que terceras partes no autorizadas nunca podrán romper estas medidas o usar su información personal para fines indebidos.</span></p>\r\n<p class="p2"><span class="s1"><strong>Menores de edad</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco no está dirigido a personas menores de 18 años de edad, salvo en aquellos supuestos en donde la legislación aplicable así lo permita.</span></p>\r\n<p class="p2"><span class="s1"><strong>Cambios en el Compromiso de Privacidad</strong></span></p>\r\n<p class="p2"><span class="s1">Usted podrá consultar en cualquier momento nuestro Compromiso de Privacidad. Si en cualquier momento tiene preguntas o dudas sobre el Compromiso de Privacidad de Dridco, no dude en contactarse a través del formulario “Contáctenos” al cual se puede acceder desde el link situados en el margen superior derecho de todas las páginas disponibles en el sitio.</span></p>\r\n<p class="p3"><span class="s1">Compromiso de Privacidad actualizado al ___________</span></p>', '', NULL, '2013-01-14 19:45:29', 1, 'backend', '2013-02-17 18:21:35', 1, 'backend', '2013-02-17 18:22:08', 1, 1, 1, 0, 'a:3:{s:9:"metatitle";s:33:"Términos y condiciones Argentina";s:15:"metadescription";s:0:"";s:4:"tags";s:0:"";}');
INSERT INTO `object` (`object_id`, `object_typeid`, `object_parent`, `object_title`, `object_shorttitle`, `object_content`, `object_summary`, `object_tags`, `creation_date`, `creation_userid`, `creation_usertype`, `modification_date`, `modification_userid`, `modification_usertype`, `publication_date`, `publication_userid`, `object_state`, `site_id`, `location_id`, `object_custom`) VALUES
(172, 1, 0, 'Estudiar posgrados, necesidad laboral', 'estudiar-posgrados-necesidad-laboral', '<p class="p1"><span class="s1"><strong>CIUDAD DE MÉXICO (CNNExpansión.com) — </strong></span><span class="s2">Para Tania Vitela Hernández estudiar la licenciatura en comunicación "no fue suficiente", y con el fin de adquirir conocimientos más concretos de un área, que pudiera aplicar en su desempeño, estudió una maestría.</span></p>\r\n<p class="p2"><span class="s2">"Ya tenía un puesto laboral, pero necesitaba generar un valor agregado y sentí que a través de esta alternativa lo conseguiría. Además hay carreras donde sientes que te enseñan de todo y, a la vez, ‘nada'', así que este recurso permite especializarte, y lo puedes ir desarrollando mientras trabajas", expresa.</span></p>\r\n<p class="p2"><span class="s2">Cursar un postgrado es un <em>plus </em>en el currículo, pues "actualmente los mejores puestos son para quienes estén actualizados, alertas al cambio y con la capacidad de aplicar nuevas técnicas ante escenarios reales", indica David García Junco, director de Educación Continua de la Universidad Iberoamericana (UIA).</span></p>\r\n<p class="p2"><span class="s3"><a href="http://www.cnnexpansion.com/especiales/los-mejores-mba-2009">La maestría y el doctorado, menciona, llaman la atención de los reclutadores</a></span><span class="s2"> porque simbolizan un esfuerzo adicional por parte de un candidato. La persona puede, a través de esta herramienta, profundizar en conocimientos apreciados en el mercado laboral, entre estos, la resolución práctica de problemas que se presentan en diversos rubros de la empresa.</span></p>\r\n<p class="p2"><span class="s2">El precio que los aspirantes deben cubrir por estudiar en alguna institución privada supera los 20,000 pesos, por semestre (tales cifras varían en caso de universidades públicas); ese fue el caso de Tania, quien debió pagar alrededor de 25,000 mensuales en la Universidad Anáhuac del Sur.</span></p>\r\n<p class="p2"><span class="s2">Sin embargo, "el retorno de esta inversión medido en incremento del salario al obtener el grado puede superar hasta un 60%, según la base salarial que se tenía al iniciar estos estudios y la especialización", indica el representante de la UIA.</span></p>\r\n<p class="p2"><span class="s2">Leer estas cifras seguro "te mueve el tapete", pero antes de tomar la decisión de especializarte debes reflexionar en ciertos puntos que, si bien parecen insignificantes, son valiosos al momento de elegir un posgrado, como: tiempo de traslados, horarios de estudio y costos, comenta Carlos Cienfuegos, director de posgrados de la Universidad Tecnológica de México (UNITEC).</span></p>\r\n<p class="p2"><span class="s2">"Si la persona trabaja, tiene que demostrar a sus superiores las ventajas de cursar un estudio de este tipo. Lo que el jefe quiere saber es qué recibirá a cambio del tiempo que otorgará a la persona. En otras palabras: tipo de habilidades que aportará a la organización, adicionales a aquéllas por las que fue contratada", explica Cienfuegos.</span></p>\r\n<p class="p2"><span class="s2"><strong>¿Local o extranjera?</strong></span></p>\r\n<p class="p2"><span class="s2">Realizar una maestría o doctorado en México permite "estudiar y trabajar al mismo tiempo. Así la persona no pierde sus contactos laborales sino que los fortalece porque aplica los conocimientos adquiridos de forma inmediata", explica Jorge Ledesma, director de la División de Posgrados de la Escuela Bancaria Comercial (EBC).</span></p>\r\n<p class="p2"><span class="s2">Agrega que otro beneficio es el costo, pues aunque los posgrados no son tan económicos, el estudiante no debe financiar una estancia como sucede cuando sale al extranjero.</span></p>\r\n<p class="p2"><span class="s2">"Aunque se tenga cierta beca la persona termina por destinar parte de su dinero para manutención, entre otros gastos", dice.</span></p>\r\n<p class="p2"><span class="s2">El director de la División de Negocios y Posgrados del Tecnológico de Monterrey, campus Santa Fe, Mario De Marchis, asegura que elegir una institución mexicana no significa carecer de experiencia internacional.</span></p>\r\n<p class="p2"><span class="s2">Por el contrario, afirma, las universidades son concientes de que sus estudiantes necesitan conocer diversos modelos de trabado e idiomas para adecuarse a la demanda empresarial, especialmente si buscan o están desempeñándose en una compañía trasnacional.</span></p>\r\n<p class="p2"><span class="s2">"Esta inquietud por buscar la competencia internacional propicia que cada vez más instituciones incluyan la participación de profesiones extranjeros y la opción de doble titulación; esto, en conjunto con la oportunidad de llevar el aprendizaje inmediato al ámbito laboral, genera un impacto positivo para el interesado en estudiar, localmente, y no fuera del país", añade el director.</span></p>\r\n<p class="p2"><span class="s2">Si ya reflexionaste los factores mencionados y reafirmaste tu interés por cursar estudios de posgrado, estás realizando una inversión a futuro y ahora es momento de elegir el programa que responda a tus necesidades.</span></p>\r\n<p class="p2"><span class="s2">Antes de elegir el área donde especializarte, piensa en los motivos que te impulsan a decidirte por esta actividad; no lo tomes a la ligera, ya que esta decisión influirá, en gran medida, en tu futuro personal y profesional. Para mayor información sobre el tema puedes consultar páginas, como la de la Asociación Nacional de Universidades e Instituciones de Educación Superior, ANUIES: <a href="http://www.anuies.mx/"><span class="s3">www.anuies.mx</span></a></span></p>\r\n<p class="p3"> </p>\r\n<p class="p4"><span class="s2"><strong>Radiografía de la especialización</strong></span></p>\r\n<p class="p4"><span class="s2">- Los posgrados de mayor demanda (46.9%) pertenecen al área de Ciencias Sociales y Ciencias Administrativas.</span></p>\r\n<p class="p4"><span class="s2">- Los menos demandados (16%) son los de Ciencias Agropecuarias.</span></p>\r\n<p class="p4"><span class="s2">- En México, alrededor de 526 instituciones ofrecen postgrados: aproximadamente 1,183 son programas de especialización, 2,851 de maestría, y 516 doctorado.</span></p>\r\n<p class="p5"> </p>\r\n<p class="p6"> </p>\r\n<p class="p7"><span class="s1">Por: </span><span class="s4">Ivonne Vargas</span></p>\r\n<p class="p2"><span class="s2"><em>Fuente: CNNExpansión.com con datos de ANUIES.</em></span></p>', '<p class="p1"><span class="s1">Continuar los estudios se ha vuelto una necesidad ante las exigencias del mercado laboral; este tipo de preparación exige esfuerzo y tiempo, pero te abre la puerta a mejores puestos.</span></p>', '', '2013-02-18 17:45:53', 1, 'backend', '2013-03-07 15:54:45', 1, 'backend', '2013-03-07 15:55:36', 1, 1, 1, 0, 'a:3:{s:9:"metatitle";s:37:"Estudiar posgrados, necesidad laboral";s:15:"metadescription";s:204:"                  Continuar los estudios se ha vuelto una necesidad ante las exigencias del mercado laboral; este tipo de preparación exige esfuerzo y tiempo, pero te abre la puerta a mejores puest [...]";s:6:"header";s:0:"";}'),
(171, 1, 0, 'Mayor capacitación mejora tu empleabilidad', 'mayor-capacitacion-mejora-tu-empleabilidad', '<p class="p1"><span class="s1">….aún si no terminaste tus estudios primarios o secundarios, tomate unos minutos que esta nota te puede ayudar…</span></p>\r\n<p class="p2"><span class="s1">La </span><span class="s2"><strong>empleabilidad </strong></span><span class="s1">es un concepto que hace referencia  al </span><span class="s3">potencial</span><span class="s1"> que tiene un individuo de ser solicitado por una empresa para trabajar en ella. Sería la sumatoria de sus capacidades, habilidades y formación que pueda ofrecer al mercado laboral. Es claro que cada vez que se prepare mejor, usted aumentará las posibilidades de ser elegido como mejor candidato ante un empleador.</span></p>\r\n<p class="p3"> </p>\r\n<p class="p2"><span class="s1">En esta nota en particular, me gustaría que nos centremos específicamente en la “Capacitación” como herramienta clave para mejorar nuestra empleabilidad. La capacitación/formación es la que actúa en aquellos momentos en que “alguien debe o quiere hacer algo, pero que no sabe cómo hacerlo”…siendo esta definición muy casera, lo que intento es aclarar que la capacitación no es solo “formal” (ej. a través de un instituto que le otorgue un diploma) sino que por el contrario estamos la mayor parte del tiempo capacitándonos, tal vez hasta sin darnos cuenta. Cada vez que un jefe nos retroalimenta diciendo lo que hicimos mal y cómo hacerlo bien… cuando un amigo nos enseña a usar mejor las redes sociales… cuando día a día ejecutamos un sistema y vamos ganando en el mejor manejo del mismo …estamos capacitándonos.</span></p>\r\n<p class="p2"><span class="s1">Cada profesión, tiene sus capacitaciones técnicas y específicas que contribuyen a una mejor formación profesional, pero es difícil detenernos en ello porque deberíamos armar una guía. Para aquellos que han accedido al mundo universitario, no creo que encuentren dificultades en cómo y dónde formarse, ya que disponen de un arsenal de profesores con quienes compartir inquietudes y solicitar sugerencias. Sin embargo, las dificultades en formaciones, aparecen generalmente, en aquellos que aún no han terminado sus estudios primarios o secundarios y se ven impedidos de ser capacitados porque les exigen títulos, o tal vez por cuestiones económicas o simplemente por no saber a dónde ni cómo acceder. Por ello lo que sí pretendo compartir en esta nota son algunos espacios públicos de acceso gratuito, que le pueden ayudar a mejorar  su empleabilidad y mantener una red de contactos con aquellos que se encuentran en la misma situación.</span></p>\r\n<p class="p3"> </p>\r\n<p class="p2"><span class="s1">El Ministerio de Trabajo, Empleo y Seguridad Social de la Argentina tiene actualmente dos programas vigentes que ayudan a la inserción laboral a través de la capacitación. Lo importante de saber es que ambos programas aplican a las distintas provincias de la Argentina, depende el lugar de residencia de cada uno deberá llamar a la oficina correspondiente.</span></p>\r\n<p class="p2"><span class="s1">A continuación les comparto algunos detalles para los interesados:</span></p>\r\n<p class="p4"><span class="s4"><strong>Jóvenes con Más y Mejor trabajo </strong><a href="http://www.trabajo.gov.ar/jovenes/"><span class="s5"><strong>http://www.trabajo.gov.ar/jovenes/</strong></span></a></span></p>\r\n<p class="p2"><span class="s1">Es un Programa destinado a brindar un conjunto de prestaciones integradas de apoyo a la construcción e implementación de un proyecto formativo y ocupacional para los jóvenes. El objetivo es generar oportunidades de inclusión social y laboral de los jóvenes, a través de acciones integradas, que les permitan construir el perfil profesional en el cual deseen desempeñarse, finalizar su escolaridad obligatoria, realizar experiencias de formación y prácticas calificantes en ambientes de trabajo, iniciar una actividad productiva de manera independiente o insertarse en un empleo.</span></p>\r\n<p class="p2"><span class="s1">Los requisitos que se exigen para poder participar es tener una edad entre 18 a 24 años, tener residencia permanente en el país, </span><span class="s3">no</span><span class="s1"> haber completado el nivel primario y/o secundario de escolaridad y adicionalmente que se encuentren desempleados.</span></p>\r\n<p class="p2"><span class="s1">Para los jóvenes interesados en participar del programa, deberán solicitar una entrevista en la Oficinade Empleo Municipal correspondiente a su domicilio de residencia. O comunicarse al Tel.: 0800-222-2220 (011) 4310-5854, o enviar un mail: <a href="mailto:jovenes@trabajo.gob.ar"><span class="s5">jovenes@trabajo.gob.ar</span></a>. Allí deberán presentar el DNI y la constancia de CUIL. Un orientador entrevistará a los jóvenes interesados para ampliar la información y completará o actualizará su historia laboral. Finalizado este registro, ambas partes firmarán un convenio de adhesión al programa que se remitirá, para su validación, a las Gerencias de Empleo y Capacitación Laboral del MTEySS.</span></p>\r\n<p class="p3"> </p>\r\n<p class="p4"><span class="s4"><strong>Red de servicios de empleos </strong><a href="http://www.trabajo.gov.ar/redempleo/"><span class="s5"><strong>http://www.trabajo.gov.ar/redempleo/</strong></span></a></span></p>\r\n<p class="p2"><span class="s1">Esta red garantiza la prestación de servicios de empleo, orientados a interrelacionar un conjunto de herramientas de políticas activas de empleo articulando tres ejes fundamentales: orientación laboral, calificación/formación profesional e inserción laboral.</span></p>\r\n<p class="p2"><span class="s1">Los destinatarios o potenciales usuarios serían:</span></p>\r\n<p><span class="s1">Personas con problemas de empleo: Desocupados, Subocupados, Beneficiarios de Programas, Personas que desean cambiar de empleo, entre otros</span> <span class="s1">Empleadores: empresas grandes, PYMES, Particulares, Estado, Cooperativas, etc.</span> <span class="s1"> Microemprendedores</span></p>\r\n<p class="p2"><span class="s1">En el caso de los primeros destinatarios, podrán acceder a:</span></p>\r\n<p><span class="s1"> Diferentes capacitaciones (talleres) desde transferencia de conocimientos específicos de oficios, como así también preparación para que usted pueda reconocer cuáles son sus propios recursos y cómo hacer uso de ellos.</span> <span class="s1">  Dejar su CV, junto con su historia laboral, para que la red pueda postularlo a las ofertas de empleos que se encuentren vigentes. En el caso que usted no tenga su CV armado, ellos le ayudan con el armado del mismo, dándoles un soporte y acompañamiento por medio de un especialista.</span> <span class="s1"> La disposición de un especialista que lo oriente en caso que usted quiera desarrollar un emprendimiento independiente y no sepa bien cómo hacerlo.</span> <span class="s1">  Experiencias profesionales en puestos reales sin poseer conocimientos previos, ni preparación alguna.</span></p>\r\n<p class="p6"> </p>\r\n<p class="p7"><span class="s1"><strong>Por último, les comparto 3 tips para tener en cuenta en relación a este tema:</strong></span></p>\r\n<p><span class="s1"> Cada vez que realice cualquier <strong>modificación en su perfil profesional</strong> (ej. aprenda una herramienta de sistemas, se perfeccione con un estudio, o haya desarrollado una nueva capacidad por un desafío propuesto) recuerde que debe sumarlo en su CV y luego rentabilizarlo en una entrevista de empleo. Como venimos hablando cada nueva cosa que usted sepa hacer le asegura una mayor empleabilidad y “a mayor empleabilidad, mayor posibilidad de encontrar o de tener un mejor empleo”.</span> <span class="s1"> Realice un análisis específico para identificar cuál es su perfil, con sus fortalezas y debilidades. Recuerde que lo que usted no comenta el entrevistador no puede adivinar, y el único encargado de venderse bien es usted, por lo cuál le recomiendo la siguiente nota para ejecutar esta actividad.  <a href="http://blog.zonajobs.com/postulantes/sepa-definir-su-perfil-profesional-con-sus-fortalezas-y-debilidades/?utm_source=AutoPromo&amp;utm_medium=Banner_300x250&amp;utm_campaign=AutoPromo%2B-%2BBanner_300x250%2B-%2BBlog" target="_blank">Sepa definir su perfil profesional con sus fortalezas y debilidades</a>.<br /></span><span class="s1">Reconozca quien es la persona que impide su crecimiento, para ello lo dejo con la reflexión del siguiente texto</span></p>\r\n<p class="p8"> </p>\r\n<p class="p7"><span class="s1"><strong>Murió la persona que impedía tu crecimiento</strong></span></p>\r\n<p class="p2"><span class="s1">Un día cuando los empleados llegaron a trabajar, encontraron un enorme letrero en la recepción que decía: “ayer falleció la persona que impedía el crecimiento de usted en esta empresa. Esta invitado al velatorio en el salón principal del edificio”.<br /> Al comienzo, todos se entristecieron por la muerte de unos de sus compañeros, pero después comenzaron a sentir curiosidad por saber quien era el que estaba impidiendo el crecimiento de sus compañeros y de la empresa.<br /> La agitación era tan grande en el salón principal que tuvieron que llamar a los de seguridad para organizar la fila en el velatorio.<br /> Conforme las personas iban acercándose al ataúd, la excitación aumentaba: ¿quién será que estaba impidiendo mi progreso? Qué bueno que el infeliz murió!<br /> Uno a uno los empleados agitados se aproximaban al ataúd, miraban al difunto y tragaban seco. Se quedaban unos minutos en el más absoluto silencio, como si les hubieran tocado lo más profundo del alma.<br /> Pues bien, en el fondo del ataúd había un espejo,…cada uno se veía a si mismo…</span></p>\r\n<p class="p7"><span class="s1"><strong>“Tu vida no cambia…cuando cambia tu jefe, cuando cambia tu empresa, cuando cambia tu pareja…cuando cambian los demás.</strong></span></p>\r\n<p class="p7"><span class="s1"><strong>Tu vida cambia….cuando tú cambias…y eres responsable por ella”</strong></span></p>\r\n<p class="p3"> </p>\r\n<p class="p2"><span class="s1">Atrévete a más, aumenta tu empleabilidad y mejora tus condiciones de empleo.</span></p>\r\n<p class="p2"><span class="s1">Suerte con ello!</span></p>\r\n<p class="p3"> </p>\r\n<p class="p9"><span class="s1"><strong>Por: Sofía Carrasco, <br /> Lic. En Relaciones del Trabajo<br /> </strong></span><span class="s2"><strong>Especialista en RRHH de Zona Jobs</strong></span></p>\r\n<p class="p10"><span class="s7">Fuente: </span><span class="s3"><a href="http://blog.zonajobs.com/" target="_blank">Blog ZonaJobs</a></span></p>', '<p><span>La  empleabilidad  es un concepto que hace referencia  al  potencial  que tiene un individuo de ser solicitado por una empresa para trabajar en ella. Sería la sumatoria de sus capacidades, habilidades y formación que pueda ofrecer al mercado laboral.</span></p>', '', '2013-02-18 17:42:13', 1, 'backend', '2013-03-07 15:55:26', 1, 'backend', '2013-03-07 15:55:38', 1, 1, 1, 0, 'a:3:{s:9:"metatitle";s:43:"Mayor capacitación mejora tu empleabilidad";s:15:"metadescription";s:209:"                  La  empleabilidad  es un concepto que hace referencia  al  potencial  que tiene un individuo de ser solicitado por una empresa para trabajar en ella. Sería la sumatoria de sus cap [...]";s:6:"header";s:0:"";}'),
(170, 1, 0, '5 profesiones con mucho futuro, que ni siquiera conocías', '5-profesiones-con-mucho-futuro-que-ni-siquiera-conocias', '<p class="p1"><span class="s1">En un mundo dominado por los cambios económicos y la revolución tecnológica, tu elección vocacional es algo clave para tu futuro bienestar. ¿Tienes una vocación ya definida? ¿O aún estás en la búsqueda de algo que te entusiasme, y a la vez, te deje dinero?</span></p>\r\n<p class="p1"><span class="s1">Muchos jóvenes deciden su futuro profesional a partir de las sugerencias y los consejos de sus familias. Pero quizás no sepas que hay algunas nuevas y apasionantes carreras profesionales, en las que puedes encontrar un fabuloso medio de vida, haciendo algo que te gusta. Descúbrelo con esta guía:</span></p>\r\n<p class="p1"><span class="s1"><strong>1. Community manager</strong><br /> ¿Te pasas todo el día en Facebook y Twitter? ¿Te tienen que gritar para que te desconectes de la compu y te sientes a comer? Imagínate si, además de poder seguir conectado todo el santo día, te pagaran un sueldo por hacerlo… parece un sueño, pero es una de las profesiones del presente, y con mucho futuro. </span></p>\r\n<p class="p1"><span class="s1">La Licenciada <a href="http://www.consultoradecarrera.com.ar/mensaje_directora.php"><span class="s2"><strong>Melina Cataife</strong></span></a>, directora de la empresa <a href="http://www.consultoradecarrera.com.ar/"><span class="s2">Consultora de Carrera</span></a> y experta en temas de Recursos Humanos, explica que “el Community Manager es el representante de las empresas y las marcas en las redes sociales, y se encarga de garantizar la presencia de las mismas en la red”. Todos los conocimientos sobre las redes que ya tengas te ayudarán a desempeñarte mejor como profesional; aunque es bueno hacer un curso, por supuesto, para organizar y comprender mejor el perfil de tu tarea.</span></p>\r\n<p class="p1"><span class="s1"><strong>2. Artista multimedia</strong><br /> Esto es para ti si manejas como un dios las herramientas de audio y diseño digital, y eres un maestro para hacer blogs, páginas webs, insertar vídeos de Youtube, o retocar fotos del Face… Y es para ti si no sabes hacer nada de esto, ¡pero te encantaría! Cualquiera sea tu caso, esta profesión puede ser la tuya. El Artista Multimedia debe manejar herramientas de diseño, de animación, de sonido y de administración de contenidos. “Al igual que el Community Manager, son profesiones que nacen a partir de la web 2.0; e incluye tareas tales como el diseño y mantenimiento de páginas webs, newsletters, presentaciones multimedia, etc.” nos explica la Lic. Cataife.</span></p>\r\n<p class="p1"><span class="s1"><strong>3. Especialista en SEO</strong><br /> Otra carrera más ligada a la tecnología, especial para amantes de la vida on-line. Los expertos en SEO son los que se encargan de que el público que navega por Internet pueda encontrar los contenidos de una determinada web en los buscadores; su misión es posicionar la página de sus clientes, para que puedan competir con otras empresas; para ello, se especializan en identificar las palabras clave, analizar el marketing on line de sus competidores… ¡algo que puede ser muy divertido! Y que cada vez tiene más demanda.</span></p>\r\n<p class="p1"><span class="s1">Tanto para ejercer este nuevo oficio, como para los otros dos mencionados anteriormente, es una ventaja enorme ser bilingüe, condición que nos distingue a la mayoría de los Latinos. ¿Por qué? Porque muchas empresas ya comunican sus productos en inglés y español, y un profesional que pueda cubrir las dos demandas, resulta ideal ¡y puede ganar más!</span></p>\r\n<p class="p1"><span class="s1"><strong>4. Ingeniería medioambiental</strong><br /> Por la enorme contaminación del planeta, ésta es una de las profesiones con más futuro: la llamada ingeniería “verde”, o ingeniería medioambiental. Es especialmente interesante si te apasiona la ecología y te preocupa la preservación ambiental, ya que la misión que cumple este profesional, es proveer alternativas ecológicas y sustentables a las tecnologías tradicionales, así como el saneamiento y la limpieza de zonas con suelos y aguas contaminadas. Se calcula que en pocos años se duplicará la demanda laboral en este sector.</span></p>\r\n<p class="p1"><span class="s1"><strong>5. Nanomedicina</strong><br /> Si te interesa la medicina, pero no estás convencido del todo de seguir esta tradicional carrera profesional, tenemos buenas noticias: te puede interesar ser un nano-médico. Combinando la tecnología de punta con el noble oficio de curar, la Nanomedicina es la especialización en aparatos muy pequeños, especialmente diseñados para implantes y cirugías muy precisas y localizadas. Esta especialidad puede cambiar radicalmente la calidad de vida de la humanidad, y es un rubro en el cual lo mejor y lo más interesante, aún está por venir.</span></p>\r\n<p class="p2"><span class="s3"><br /> </span><span class="s1">Por: Elizabeth Levy Sad</span></p>\r\n<p class="p3"><span class="s1">Fuente: Revista Men’s Life Today</span></p>', '<p><span>En un mundo dominado por los cambios económicos y la revolución tecnológica, tu elección vocacional es algo clave para tu futuro bienestar. ¿Tienes una vocación ya definida? ¿O aún estás en la búsqueda de algo que te entusiasme, y a la vez, te deje dinero?</span></p>', '', '2013-02-18 17:37:10', 1, 'backend', '2013-03-07 15:55:20', 1, 'backend', '2013-03-07 15:55:41', 1, 1, 1, 0, 'a:3:{s:9:"metatitle";s:57:"5 profesiones con mucho futuro, que ni siquiera conocías";s:15:"metadescription";s:211:"                  En un mundo dominado por los cambios económicos y la revolución tecnológica, tu elección vocacional es algo clave para tu futuro bienestar. ¿Tienes una vocación ya definida? ¿O aú [...]";s:6:"header";s:0:"";}');

-- --------------------------------------------------------

--
-- Table structure for table `object_category`
--

DROP TABLE IF EXISTS `object_category`;
CREATE TABLE `object_category` (
  `object_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `category_parentid` int(11) NOT NULL DEFAULT '0',
  `category_order` int(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `object_category`
--

INSERT INTO `object_category` (`object_id`, `category_id`, `category_parentid`, `category_order`) VALUES
(170, 103, 2, 0),
(171, 103, 2, 0),
(172, 106, 2, 0),
(173, 106, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `object_deleted`
--

DROP TABLE IF EXISTS `object_deleted`;
CREATE TABLE `object_deleted` (
  `object_id` int(11) NOT NULL,
  `object_typeid` int(11) NOT NULL DEFAULT '0',
  `object_parent` int(11) NOT NULL DEFAULT '0',
  `object_title` varchar(500) DEFAULT '',
  `object_shorttitle` varchar(255) DEFAULT '',
  `object_content` text,
  `object_summary` text,
  `object_tags` varchar(255) DEFAULT NULL,
  `creation_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `creation_userid` int(4) NOT NULL DEFAULT '0',
  `creation_usertype` varchar(50) DEFAULT '',
  `modification_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modification_userid` int(4) NOT NULL DEFAULT '0',
  `modification_usertype` varchar(50) DEFAULT '',
  `publication_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publication_userid` int(4) NOT NULL DEFAULT '0',
  `object_state` int(1) NOT NULL DEFAULT '0',
  `country_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) NOT NULL DEFAULT '0',
  `object_custom` text
) ENGINE=MyISAM AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `object_deleted`
--

INSERT INTO `object_deleted` (`object_id`, `object_typeid`, `object_parent`, `object_title`, `object_shorttitle`, `object_content`, `object_summary`, `object_tags`, `creation_date`, `creation_userid`, `creation_usertype`, `modification_date`, `modification_userid`, `modification_usertype`, `publication_date`, `publication_userid`, `object_state`, `country_id`, `location_id`, `object_custom`) VALUES
(179, 1, 0, 'test', 'test', NULL, NULL, NULL, '2013-07-18 16:46:16', 1, 'backend', '0000-00-00 00:00:00', 0, '', '0000-00-00 00:00:00', 0, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `object_relation`
--

DROP TABLE IF EXISTS `object_relation`;
CREATE TABLE `object_relation` (
  `object_id` int(11) NOT NULL DEFAULT '0',
  `object_typeid` int(11) NOT NULL DEFAULT '0',
  `object_relationid` int(11) NOT NULL DEFAULT '0',
  `object_relation_typeid` int(11) NOT NULL DEFAULT '0',
  `object_relation_order1` int(11) NOT NULL DEFAULT '0',
  `object_relation_order2` int(11) NOT NULL DEFAULT '0',
  `object_relation_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `object_type`
--

DROP TABLE IF EXISTS `object_type`;
CREATE TABLE `object_type` (
  `object_typeid` int(11) NOT NULL,
  `object_typename` varchar(100) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `object_type`
--

INSERT INTO `object_type` (`object_typeid`, `object_typename`) VALUES
(1, 'project'),
(2, 'promo'),
(3, 'page'),
(4, 'country');

-- --------------------------------------------------------

--
-- Table structure for table `partida`
--

DROP TABLE IF EXISTS `partida`;
CREATE TABLE `partida` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  `responsable` varchar(100) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date` datetime NOT NULL,
  `creation_userid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partida`
--

INSERT INTO `partida` (`id`, `description`, `responsable`, `project_id`, `amount`, `date`, `creation_userid`) VALUES
(1, 'Descripción de la partida', 'Ariel Velaz', 6, '40000.00', '0000-00-00 00:00:00', 1),
(2, 'Otra Partida', 'Adrian', 6, '12012.00', '2014-07-02 00:00:00', 1),
(3, 'Otra Partida 222', 'Adrian', 6, '12012.00', '2014-07-02 00:00:00', 1),
(4, 'Otra Partida 333', 'Dario', 6, '25000.00', '2014-07-02 00:00:00', 1),
(5, 'Partida #1', 'Matias', 8, '1200.00', '2011-11-11 00:00:00', 1),
(6, 'Partida #2', 'Jorge', 8, '1200.00', '2014-07-02 00:00:00', 1),
(10, 'Lorem ipsum', 'Matias', 10, '1200.00', '2014-07-11 00:00:00', 1),
(8, 'Partida #3', 'Guillermo', 8, '5000.00', '2014-07-02 00:00:00', 1),
(9, 'Lorem ipsum', 'Adrian', 8, '1200.00', '2014-07-02 00:00:00', 1),
(11, 'Otra Partida', 'Matias', 10, '1000.00', '2014-07-02 00:00:00', 1),
(12, 'Danger Partida', 'Matias', 10, '1200.00', '2014-07-02 00:00:00', 1),
(15, 'Lorem ipsum', 'Matias2', 10, '5.00', '2014-07-02 00:00:00', 1),
(17, 'PArtida Solicitada por matias', 'Matias', 10, '25000.00', '2014-07-09 00:00:00', 1),
(18, 'desc', 'Matias', 14, '15000.00', '2014-07-16 00:00:00', 1),
(19, 'desc2', 'Matias', 14, '1200.00', '2014-07-16 00:00:00', 1),
(20, 'Partida de Producción', 'Adrian', 29, '1000.00', '2014-07-22 00:00:00', 1),
(21, 'Partida de Sonido', 'Matias', 29, '30000.00', '2014-07-22 00:00:00', 1),
(22, '', 'Adrian', 30, '1000.00', '2014-07-29 00:00:00', 1),
(23, '', '', 34, '1000.00', '2014-08-15 00:00:00', 1),
(24, 'movilidad 1', 'camila', 34, '1000.00', '2014-08-03 00:00:00', 1),
(25, 'Partida #7', '', 38, '4000.00', '2014-08-04 00:00:00', 18),
(26, 'Partida de producción para catering y transporte.\r\nEntregada por Sebastián Mignogna', 'Producción', 36, '450.00', '2014-08-08 00:00:00', 17),
(27, '', '', 33, '5000.00', '0000-00-00 00:00:00', 17),
(28, '', '', 33, '700.00', '0000-00-00 00:00:00', 17),
(29, '', 'Producción', 39, '450.00', '2014-08-02 00:00:00', 1),
(30, '', 'Adrian', 39, '3000.00', '2014-08-14 00:00:00', 1),
(31, 'Partida # 8 Ausol', 'Gabriel Siperman', 38, '3000.00', '2014-09-09 00:00:00', 18),
(32, 'partida # 1', 'Gabriel Siperman', 51, '4000.00', '2015-05-11 00:00:00', 18),
(33, 'partida # 2\r\n', 'Gabriel Siperman', 51, '2000.00', '2015-06-24 00:00:00', 18),
(34, 'Quiero guita', 'Ariel Velaz', 55, '100.00', '2016-12-26 00:00:00', 1),
(35, 'Partida para Rafa para que compre biscochitos', 'Rafa', 58, '3000.00', '2017-09-12 00:00:00', 1),
(36, 'Leandro que compre xxx', 'Lean', 58, '1000.00', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
CREATE TABLE `payment_method` (
  `id` int(11) unsigned NOT NULL,
  `title` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`id`, `title`) VALUES
(1, 'Cheque'),
(2, 'Transferencia');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `shorttitle` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `type_option_programas` varchar(100) DEFAULT NULL,
  `type_option_segundaje` varchar(100) DEFAULT NULL,
  `type_option_producto` varchar(100) DEFAULT NULL,
  `type_option_duracion` varchar(100) DEFAULT NULL,
  `type_option_medio` varchar(100) DEFAULT NULL,
  `type_option_tipo_servicio` varchar(100) DEFAULT NULL,
  `budget` varchar(100) NOT NULL DEFAULT '0',
  `imprevistos` decimal(5,2) NOT NULL DEFAULT '0.00',
  `ganancia` decimal(5,2) NOT NULL DEFAULT '0.00',
  `impuestos` decimal(5,2) NOT NULL DEFAULT '0.00',
  `iva` decimal(5,2) NOT NULL,
  `costo_operativo` decimal(10,0) NOT NULL,
  `porcentaje_costo_operativo` int(11) NOT NULL,
  `indice_epl` decimal(10,2) NOT NULL,
  `impuesto_cheque` decimal(5,2) NOT NULL,
  `otros_impuestos` decimal(5,2) NOT NULL,
  `creation_date` date NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `client_id` int(11) NOT NULL DEFAULT '0',
  `type` varchar(100) NOT NULL,
  `creation_userid` int(11) NOT NULL DEFAULT '0',
  `modification_userid` int(11) NOT NULL DEFAULT '0',
  `modification_usertype` int(11) NOT NULL,
  `state` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `title`, `shorttitle`, `description`, `type_option_programas`, `type_option_segundaje`, `type_option_producto`, `type_option_duracion`, `type_option_medio`, `type_option_tipo_servicio`, `budget`, `imprevistos`, `ganancia`, `impuestos`, `iva`, `costo_operativo`, `porcentaje_costo_operativo`, `indice_epl`, `impuesto_cheque`, `otros_impuestos`, `creation_date`, `start_date`, `end_date`, `client_id`, `type`, `creation_userid`, `modification_userid`, `modification_usertype`, `state`) VALUES
(38, 'AUSOL Fee mensual - Agosto', 'ausol-fee-mensual-agosto', 'Mantenimiento mensual, time lapse, edición y salidas de rodaje', '', '', '', '', '', 'material de TV', '0', '2.00', '24.62', '1.20', '21.00', '0', 0, '0.00', '1.00', '0.00', '2014-08-08', '2014-08-01', '2014-08-31', 10, 'Servicio', 18, 12, 0, 2),
(30, 'PROYECTO DE TV', 'proyecto-de-tv', 'descripción del proyecto', '10', '24 minutos', '', '', '', '', '0', '3.00', '25.00', '1.20', '21.00', '0', 0, '0.00', '0.00', '0.00', '2014-07-28', '2014-07-01', '2014-07-10', 4, 'TV', 1, 18, 0, 1),
(31, 'PROYECTO DE PUBLICIDAD', 'proyecto-de-publicidad', '                        \r\n                      ', '', '', 'DISNEY PRINCESAS', '10 HORAS', 'WEB', '', '0', '3.00', '20.00', '1.20', '0.00', '0', 0, '0.00', '0.00', '0.00', '2014-07-28', '2014-08-05', '2014-08-27', 8, 'Publicidad', 1, 12, 0, 0),
(36, 'Cultura - Invasiones Inglesas', 'cultura-invasiones-inglesas', 'Micro de  3/4 minutos para el Ministerio de Cultura.\r\nRecrea la reconquista de Buenos Aires en 1806 a partir de una historieta.', '1', '4 minutos', '', '', '', '', '0', '0.00', '20.00', '21.00', '0.00', '0', 0, '0.00', '0.00', '0.00', '2014-08-07', '2014-08-07', '2014-08-11', 9, 'TV', 17, 16, 0, 1),
(33, 'Spot Defensa del Consumidor', 'spot-defensa-del-consumidor', '                        \r\n                      ', '1', '3 min 30 seg', '', '', '', '', '0', '0.00', '10.00', '21.00', '0.00', '0', 0, '0.00', '0.00', '0.00', '2014-07-30', '2014-07-23', '2014-07-31', 8, 'TV', 12, 12, 0, 1),
(39, 'Proyecto de Prueba', 'proyecto-de-prueba', 'Descripción', '2', '10 días', '', '', '', '', '0', '3.00', '20.00', '1.20', '21.00', '0', 0, '0.00', '0.00', '0.00', '2014-08-22', '2014-08-01', '2014-08-31', 11, 'TV', 12, 12, 0, 1),
(41, 'otro proyecto de prueba', 'otro-proyecto-de-prueba', '', '2', '10 días', '', '', '', '', '0', '3.00', '15.00', '1.20', '21.00', '0', 0, '0.00', '0.00', '0.00', '2014-09-01', '0000-00-00', '0000-00-00', 11, 'TV', 12, 0, 0, 0),
(42, 'Micros Juan Gelman', 'micros-juan-gelman', '13 micros sobre poemas de Juan Gelman, con la participación de Cristina Banegas y Tom Lupo.', '13', 'a definir ', '', '', '', '', '0', '3.00', '20.00', '1.20', '21.00', '0', 0, '0.00', '0.00', '0.00', '2014-09-03', '2014-09-03', '0000-00-00', 8, 'TV', 17, 0, 0, 0),
(43, 'Zamba Micro AMIA', 'zamba-micro-amia', '                        \r\n                      ', '1 micro', '2 minutos', '', '', '', '', '0', '0.00', '10.00', '0.00', '21.00', '0', 0, '0.00', '0.00', '0.00', '2014-09-04', '2014-05-29', '2014-07-21', 8, 'TV', 15, 12, 0, 2),
(44, 'AUSOL Fee mensual - Septiembre a Noviembre', 'ausol-fee-mensual-septiembre-a-noviembre', 'Mantenimiento mensual, time lapse, edición y salidas de rodaje', '', '', '', '', '', 'material de TV', '0', '2.00', '24.62', '1.20', '21.00', '0', 0, '0.00', '1.00', '0.00', '2014-09-04', '2014-09-01', '2014-11-30', 10, 'Servicio', 18, 18, 0, 1),
(45, 'Copia de: Proyecto de Prueba', 'copia-de-proyecto-de-prueba', 'Descripción', '2', '10 días', '', '', '', '', '0', '3.00', '20.00', '1.20', '21.00', '0', 0, '0.00', '0.00', '0.00', '2014-09-04', '2014-08-01', '2014-08-31', 11, 'TV', 18, 12, 0, 1),
(46, 'Icono Villa del Sur', 'icono-villa-del-sur', 'Desarrollo conceptual del ícono de Villa del Sur', '', '', '', '', '', 'Villa del Sur - regular', '0', '0.00', '0.00', '0.00', '0.00', '0', 0, '0.00', '0.00', '0.00', '2014-09-04', '2014-08-04', '2014-08-28', 13, 'Servicio', 18, 18, 0, 1),
(49, 'Zamba Micros energía', 'zamba-micros-energia', '3 micros de energía para planificación                        \r\n                      ', '', '', '', '', '', '', '0', '5.00', '15.00', '0.00', '21.00', '0', 0, '0.00', '0.00', '0.00', '2014-09-10', '2014-04-24', '2014-07-10', 8, 'TV', 15, 25, 0, 2),
(51, 'Autopistas del Oeste', 'autopistas-del-oeste', 'Video Institucional ', '1', '', '', '', '', '', '0', '2.00', '18.00', '1.20', '21.00', '0', 0, '0.00', '0.00', '0.00', '2015-08-19', '2015-05-01', '2015-07-01', 14, 'TV', 18, 18, 0, 1),
(52, 'Video inauguracion General paz', 'video-inauguracion-general-paz', '', '', '', '', '', '', '3 videos ', '0', '3.00', '20.00', '1.20', '21.00', '0', 11935, '0.00', '0.00', '0.00', '2015-10-20', '2015-09-14', '2015-10-09', 15, 'Servicio', 18, 0, 0, 0),
(53, 'Video Mas Cerca', 'video-mas-cerca', 'video Mas Cerca', '', '', '', '', '', '', '0', '3.00', '28.00', '1.20', '21.00', '0', 0, '0.00', '0.00', '0.00', '2015-12-02', '2015-11-18', '2015-11-30', 16, 'TV', 18, 0, 0, 0),
(54, 'Video Mas Cerca', 'video-mas-cerca', 'video Mas Cerca', '', '', '', '', '', '', '0', '3.00', '28.00', '1.20', '21.00', '0', 499718, '0.00', '0.00', '0.00', '2015-12-02', '2015-11-18', '2015-11-30', 16, 'TV', 18, 1, 0, 0),
(55, 'New Empty Project', 'new-empty-project', 'Esta es la descripción del proyecto', '', '', '', '', '', '', '0', '3.00', '20.00', '1.20', '21.00', '0', 23, '0.00', '0.00', '0.00', '2016-09-23', '2016-09-23', '2016-09-30', 16, '', 1, 1, 0, 1),
(58, 'Nuevo Proyecto', 'nuevo-proyecto', 'Descripción', '', '', '', '', '', '', '0', '3.00', '20.00', '1.20', '21.00', '5000', 100, '7333.00', '0.00', '0.00', '2017-02-13', '2017-02-01', '2017-03-15', 11, 'TV', 1, 1, 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `project_resource`
--

DROP TABLE IF EXISTS `project_resource`;
CREATE TABLE `project_resource` (
  `resource_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `rubro_id` int(11) NOT NULL,
  `subrubro_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL DEFAULT '0',
  `estimate_units` int(11) NOT NULL DEFAULT '0',
  `estimate_quantity` decimal(15,2) NOT NULL DEFAULT '0.00',
  `estimate_cost` decimal(15,2) NOT NULL,
  `units` int(11) NOT NULL DEFAULT '0',
  `quantity` decimal(15,2) NOT NULL,
  `description` varchar(100) NOT NULL,
  `concept` varchar(100) NOT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  `sindicato_percentage` int(11) NOT NULL,
  `state` int(1) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `payments` int(11) NOT NULL,
  `payment_type` varchar(100) NOT NULL,
  `creation_userid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=393 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_resource`
--

INSERT INTO `project_resource` (`resource_id`, `project_id`, `rubro_id`, `subrubro_id`, `provider_id`, `estimate_units`, `estimate_quantity`, `estimate_cost`, `units`, `quantity`, `description`, `concept`, `cost`, `sindicato_percentage`, `state`, `start_date`, `end_date`, `payments`, `payment_type`, `creation_userid`) VALUES
(6, 10, 4, 8, 0, 0, '0.00', '0.00', 0, '10.00', 'Descripción de la factura', 'Mensual', '200.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(7, 10, 4, 5, 0, 0, '0.00', '0.00', 0, '10.00', 'test222\r\n', 'Unidad', '200.00', 0, 0, '0000-00-00', '0000-00-00', 3, 'Iguales', 1),
(12, 10, 17, 28, 0, 0, '0.00', '0.00', 0, '60.00', 'Pago al Director', 'Diario', '25000.00', 0, 0, '2014-07-10', '2014-07-31', 60, 'Iguales', 1),
(13, 10, 4, 14, 0, 0, '0.00', '0.00', 0, '10.00', '', 'Programas', '200.00', 0, 0, '2014-07-11', '2014-07-12', 2, 'Iguales', 1),
(14, 9, 4, 5, 0, 0, '0.00', '0.00', 0, '10.00', 'test', 'Unidad', '1000.00', 0, 0, '2014-07-11', '2014-07-11', 3, 'Diferentes', 1),
(15, 12, 4, 5, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(21, 14, 4, 8, 0, 0, '0.00', '0.00', 0, '5.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(23, 14, 4, 11, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '15500.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(22, 14, 4, 8, 0, 0, '0.00', '0.00', 0, '5.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(20, 14, 4, 5, 0, 0, '0.00', '0.00', 0, '2.00', 'Alquiler de Cámaras', 'Unidad', '5000.00', 0, 0, '2014-07-16', '2014-07-31', 10, 'Iguales', 1),
(24, 14, 4, 9, 0, 0, '0.00', '0.00', 0, '2.00', '', 'Unidad', '25000.00', 0, 0, '1901-01-01', '1901-01-31', 1, 'Iguales', 1),
(25, 14, 32, 36, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '50000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(26, 14, 32, 37, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '30000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(27, 14, 32, 33, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '50000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(28, 17, 4, 5, 0, 0, '0.00', '0.00', 0, '12.00', 'desc', 'Mensual', '100.00', 0, 0, '2014-07-16', '2014-07-31', 1, 'Iguales', 1),
(29, 22, 4, 5, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(30, 22, 4, 8, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(31, 22, 4, 11, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(32, 25, 4, 5, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(33, 25, 4, 8, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(34, 25, 4, 11, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(35, 13, 4, 5, 0, 0, '0.00', '0.00', 0, '10.00', '', 'Mensual', '25000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(36, 13, 4, 8, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '100.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(37, 13, 4, 13, 0, 0, '0.00', '0.00', 0, '2.00', '', 'Unidad', '100.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(41, 27, 4, 8, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '100.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(39, 26, 4, 8, 0, 0, '1.00', '1000.00', 0, '0.00', '', 'Unidad', '0.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(40, 26, 4, 13, 0, 0, '2.00', '500.00', 0, '0.00', '', 'Unidad', '0.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(42, 27, 4, 13, 0, 0, '0.00', '0.00', 0, '2.00', '', 'Unidad', '100.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(47, 28, 4, 5, 0, 0, '1.00', '1000.00', 0, '2.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(48, 28, 4, 8, 0, 0, '1.00', '1000.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(49, 28, 42, 44, 0, 0, '1.00', '222.00', 0, '1.00', '', 'Unidad', '222.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(50, 28, 42, 43, 0, 0, '2.00', '1000.00', 0, '2.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(51, 29, 4, 5, 10, 0, '1.00', '1500.00', 0, '2.00', '', 'Unidad', '1300.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(52, 29, 42, 44, 0, 0, '1.00', '1000.00', 0, '1.00', '', 'Unidad', '800.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(53, 29, 4, 8, 11, 0, '10.00', '1000.00', 0, '9.00', 'Luces Ambientales', 'Unidad', '1000.00', 0, 0, '2014-07-01', '2014-07-10', 1, 'Iguales', 1),
(54, 29, 4, 11, 7, 0, '1.00', '1000.00', 0, '2.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(55, 29, 4, 14, 7, 0, '2.00', '13.00', 0, '3.00', 'test', 'Unidad', '13.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(56, 31, 4, 8, 9, 0, '0.00', '0.00', 0, '0.00', '', 'Unidad', '0.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(57, 32, 4, 8, 11, 0, '0.00', '0.00', 0, '0.00', '', 'Mensual', '0.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(58, 28, 4, 13, 8, 0, '1.00', '1500.00', 0, '1.00', '', 'Unidad', '1500.00', 0, 0, '2014-07-02', '2014-07-09', 2, 'Iguales', 1),
(59, 30, 4, 5, 43, 1, '3.00', '1000.00', 1, '3.00', '', 'Mensual', '1000.00', 0, 0, '2014-07-29', '2014-09-30', 0, '', 1),
(143, 33, 6, 82, 21, 1, '1.00', '2000.00', 1, '1.00', '', '', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(144, 38, 32, 17, 39, 1, '1.00', '19000.00', 1, '1.00', '', 'Unidad', '19000.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(138, 33, 38, 40, 48, 1, '1.00', '7500.00', 1, '1.00', '', '', '2115.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(107, 35, 4, 5, 36, 0, '1.00', '1000.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '2014-08-01', '2014-08-21', 0, '', 1),
(69, 34, 42, 43, 36, 0, '1.00', '4200.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(106, 34, 42, 43, 36, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(105, 34, 42, 43, 36, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(103, 34, 50, 56, 36, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(78, 34, 18, 57, 0, 0, '1.00', '1800.00', 0, '1.00', '', 'Global', '1800.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(79, 34, 18, 58, 0, 0, '1.00', '7500.00', 0, '1.00', '', 'Global', '7500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(104, 34, 42, 43, 36, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(83, 34, 60, 63, 0, 0, '1.00', '3500.00', 0, '1.00', '', 'Global', '3500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(95, 34, 66, 67, 0, 0, '1.00', '90.00', 0, '1.00', '', 'Global', '90.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(94, 34, 60, 64, 0, 0, '1.00', '1200.00', 0, '1.00', '', 'Global', '1200.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(86, 34, 66, 68, 0, 0, '1.00', '16.00', 0, '1.00', '', 'Global', '16.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(93, 34, 60, 65, 0, 0, '1.00', '10000.00', 0, '1.00', '', 'Global', '10000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(92, 34, 17, 28, 0, 0, '1.00', '7500.00', 0, '1.00', '', 'Global', '7500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(89, 34, 75, 76, 0, 0, '1.00', '350.00', 0, '1.00', '', 'Global', '350.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(90, 34, 75, 77, 0, 0, '1.00', '400.00', 0, '1.00', '', 'Global', '400.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(91, 34, 75, 78, 0, 0, '1.00', '300.00', 0, '1.00', '', 'Global', '300.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(108, 35, 4, 14, 0, 0, '0.00', '0.00', 0, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(110, 31, 4, 5, 34, 0, '0.00', '0.00', 0, '5.00', '', 'Diario', '10000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(145, 38, 38, 40, 40, 1, '1.00', '16520.00', 1, '1.00', '', 'Unidad', '16520.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(139, 33, 38, 41, 19, 1, '1.00', '4000.00', 1, '1.00', '', '', '336.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(137, 33, 42, 43, 14, 1, '1.00', '4000.00', 1, '1.00', '', '', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(140, 33, 50, 56, 23, 1, '1.00', '6500.00', 1, '1.00', '', '', '3000.00', 0, 0, '0000-00-00', '2014-09-04', 0, 'Iguales', 14),
(136, 33, 17, 28, 12, 1, '1.00', '12000.00', 1, '1.00', '', '', '10000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(111, 36, 32, 34, 40, 0, '1.00', '9000.00', 0, '1.00', 'Dirección', 'Unidad', '6000.00', 0, 0, '2014-08-08', '2014-08-11', 2, 'Iguales', 17),
(112, 36, 38, 40, 0, 0, '1.00', '5500.00', 0, '1.00', '', 'Unidad', '2800.00', 0, 0, '0000-00-00', '0000-00-00', 2, 'Iguales', 17),
(113, 36, 50, 53, 0, 0, '1.00', '6000.00', 0, '1.00', 'Leandro Piccarreta', 'Unidad', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(114, 36, 50, 56, 0, 0, '1.00', '2000.00', 0, '1.00', 'Posibles horas extras de editor fin de semana', 'Unidad', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(115, 36, 60, 64, 0, 0, '3.00', '350.00', 0, '0.00', '', 'Unidad', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(116, 36, 42, 43, 30, 0, '1.00', '1500.00', 0, '0.00', 'Martín o Rai?', 'Unidad', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(117, 36, 66, 69, 0, 0, '2.00', '1500.00', 0, '1.00', 'Estación Animación + Estación edición', 'Unidad', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(118, 36, 66, 68, 0, 0, '10.00', '15.00', 0, '0.00', 'Material Virgen para entrega', 'Global', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(119, 36, 18, 58, 0, 0, '1.00', '2500.00', 0, '1.00', 'Locutor', 'Unidad', '4000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(121, 36, 75, 76, 0, 0, '1.00', '500.00', 0, '0.00', 'Seguros varios', 'Unidad', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(122, 36, 60, 63, 0, 0, '1.00', '3000.00', 0, '1.00', 'Sono, mezcla y musicalización', 'Unidad', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(123, 36, 16, 29, 0, 0, '1.00', '2500.00', 0, '1.00', 'Comidas', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(124, 37, 32, 34, 0, 0, '1.00', '9000.00', 0, '1.00', 'Dirección', 'Unidad', '9000.00', 0, 0, '2014-08-08', '2014-08-11', 0, '', 17),
(125, 37, 38, 40, 0, 0, '1.00', '5500.00', 0, '1.00', 'Productor', 'Unidad', '5500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(126, 37, 50, 53, 0, 0, '1.00', '6000.00', 0, '1.00', 'Leandro Piccarreta', 'Unidad', '6000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(127, 37, 50, 56, 0, 0, '1.00', '2000.00', 0, '1.00', 'Posibles horas extras de editor fin de semana', 'Unidad', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(128, 37, 60, 64, 25, 0, '3.00', '350.00', 0, '3.00', '', 'Unidad', '350.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(129, 37, 42, 43, 31, 0, '1.00', '1500.00', 0, '1.00', 'Martín o Rai?', 'Unidad', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(130, 37, 66, 69, 0, 0, '2.00', '1500.00', 0, '2.00', 'Estación Animación + Estación edición', 'Unidad', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(131, 37, 66, 68, 0, 0, '10.00', '15.00', 0, '0.00', 'Material Virgen para entrega', 'Global', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(132, 37, 18, 58, 0, 0, '1.00', '2500.00', 0, '1.00', 'Locutor', 'Unidad', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(133, 37, 75, 76, 0, 0, '1.00', '500.00', 0, '0.00', 'Seguros varios', 'Unidad', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(134, 37, 60, 63, 24, 0, '1.00', '3000.00', 0, '1.00', 'Sono, mezcla y musicalización', 'Unidad', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(135, 37, 16, 29, 0, 0, '1.00', '2500.00', 0, '1.00', 'Comidas', 'Unidad', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(146, 38, 6, 82, 40, 1, '1.00', '8400.00', 1, '1.00', '', '', '16000.00', 0, 0, '2014-08-01', '2014-08-31', 0, 'Iguales', 18),
(147, 38, 6, 84, 0, 1, '1.00', '1680.00', 1, '1.00', '', '', '1680.00', 0, 0, '2014-08-01', '2014-08-31', 1, 'Iguales', 18),
(148, 38, 6, 7, 0, 1, '1.00', '2100.00', 1, '1.00', '', 'Unidad', '2100.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(149, 38, 6, 85, 40, 1, '1.00', '20000.00', 1, '1.00', '', '', '20000.00', 0, 0, '2014-08-01', '2014-08-31', 3, 'Iguales', 18),
(150, 38, 50, 56, 40, 1, '1.00', '9100.00', 1, '1.00', '', 'Unidad', '9100.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(151, 38, 60, 63, 0, 1, '1.00', '3000.00', 1, '1.00', '', 'Unidad', '3000.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(152, 38, 60, 83, 0, 1, '1.00', '6000.00', 1, '1.00', '', 'Unidad', '6000.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(153, 38, 60, 86, 0, 1, '1.00', '1600.00', 1, '1.00', '', 'Unidad', '1600.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(178, 38, 60, 102, 0, 1, '1.00', '6000.00', 1, '1.00', '', 'Unidad', '6000.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(155, 38, 50, 87, 0, 1, '1.00', '4500.00', 1, '1.00', '', 'Unidad', '4500.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(156, 38, 4, 5, 40, 1, '6.00', '500.00', 1, '6.00', '', 'Unidad', '500.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(157, 38, 4, 88, 0, 1, '3.00', '250.00', 1, '3.00', '', 'Unidad', '250.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(158, 38, 4, 11, 40, 1, '1.00', '600.00', 1, '1.00', '', 'Unidad', '600.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(159, 38, 89, 90, 40, 1, '1.00', '1200.00', 1, '1.00', '', 'Unidad', '1200.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(160, 38, 91, 92, 0, 1, '1.00', '10000.00', 1, '1.00', '', 'Unidad', '10000.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(161, 38, 91, 95, 40, 1, '1.00', '3500.00', 1, '1.00', '', 'Unidad', '3500.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(162, 38, 16, 97, 40, 1, '1.00', '2500.00', 1, '1.00', '', 'Unidad', '2500.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(163, 38, 16, 99, 40, 1, '1.00', '1200.00', 1, '1.00', '', 'Unidad', '1200.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(164, 38, 16, 100, 40, 1, '1.00', '2000.00', 1, '1.00', '', 'Unidad', '2000.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(179, 33, 66, 101, 0, 1, '1.00', '800.00', 1, '1.00', '', 'Unidad', '800.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(166, 38, 75, 76, 42, 1, '1.00', '1200.00', 1, '1.00', '', 'Unidad', '1200.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(167, 38, 75, 77, 0, 1, '1.00', '900.00', 1, '1.00', '', 'Unidad', '900.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(168, 38, 16, 31, 40, 1, '1.00', '1294.00', 1, '1.00', '', 'Unidad', '1294.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(169, 38, 91, 96, 40, 1, '1.00', '3000.00', 1, '1.00', '', 'Unidad', '3000.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(170, 33, 89, 90, 40, 1, '1.00', '2000.00', 1, '1.00', '', '', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(171, 33, 60, 63, 25, 1, '1.00', '6000.00', 1, '1.00', '', '', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(173, 33, 16, 99, 0, 1, '1.00', '500.00', 1, '1.00', '', 'Unidad', '500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(174, 33, 75, 77, 42, 1, '1.00', '350.00', 1, '1.00', '', '', '350.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(175, 33, 75, 78, 0, 1, '1.00', '250.00', 1, '1.00', '', 'Unidad', '250.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(176, 38, 38, 41, 40, 1, '0.00', '0.00', 1, '1.00', '', '', '10511.00', 0, 0, '2014-08-01', '2014-08-31', 1, 'Iguales', 18),
(177, 38, 6, 85, 41, 1, '0.00', '0.00', 1, '0.00', '', '', '1844.00', 0, 0, '2014-08-01', '2014-08-31', 0, 'Iguales', 18),
(180, 33, 91, 96, 0, 1, '1.00', '1500.00', 1, '1.00', '', '', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 14),
(181, 33, 91, 107, 0, 1, '1.00', '2000.00', 1, '1.00', '', 'Unidad', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(182, 33, 75, 76, 40, 1, '1.00', '300.00', 1, '1.00', '', '', '255.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(183, 33, 16, 29, 0, 1, '1.00', '1000.00', 1, '1.00', '', 'Global', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(184, 33, 18, 58, 0, 1, '1.00', '8000.00', 1, '1.00', '', 'Global', '8000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(185, 33, 4, 5, 34, 1, '1.00', '2500.00', 1, '1.00', '', '', '3850.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(186, 33, 50, 87, 0, 1, '1.00', '8000.00', 1, '1.00', '', 'Global', '8000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(187, 33, 91, 107, 0, 1, '1.00', '1500.00', 1, '1.00', '', 'Global', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(188, 33, 4, 8, 29, 1, '0.00', '0.00', 1, '2900.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(189, 33, 60, 65, 24, 1, '0.00', '0.00', 1, '1.00', '', '', '5000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(227, 33, 18, 74, 0, 0, '0.00', '0.00', 0, '1.00', '', '', '218.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(228, 33, 18, 112, 0, 0, '0.00', '0.00', 0, '1.00', '', '', '3633.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(192, 33, 91, 106, 0, 1, '0.00', '0.00', 1, '0.00', '', 'Global', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(194, 39, 16, 97, 29, 2, '1.00', '1000.00', 2, '1.00', '', '', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 2, 'Iguales', 12),
(197, 41, 16, 97, 29, 1, '1.00', '1000.00', 1, '1.00', '', 'Unidad', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 12),
(195, 39, 16, 29, 43, 1, '1.00', '15000.00', 1, '1.00', '', '', '15000.00', 0, 0, '0000-00-00', '0000-00-00', 4, 'Iguales', 1),
(196, 39, 4, 5, 22, 1, '1.00', '2222.00', 1, '1.00', '', '', '2222.00', 0, 0, '0000-00-00', '0000-00-00', 5, 'Iguales', 1),
(198, 42, 42, 43, 0, 1, '13.00', '2500.00', 1, '13.00', '', 'Programas', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(200, 42, 32, 17, 0, 1, '2.00', '20000.00', 1, '2.00', '', 'Mensual', '20000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(201, 42, 32, 34, 0, 1, '13.00', '1500.00', 1, '13.00', '', 'Diario', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(202, 42, 38, 39, 0, 1, '1.00', '20000.00', 1, '1.00', '', 'Global', '20000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(203, 42, 38, 40, 0, 1, '2.00', '15000.00', 1, '2.00', '', 'Mensual', '15000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(206, 42, 6, 82, 0, 4, '13.00', '1000.00', 4, '13.00', '', 'Diario', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(205, 42, 38, 41, 0, 1, '2.00', '8000.00', 1, '2.00', '', 'Mensual', '8000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(207, 42, 6, 84, 0, 2, '13.00', '750.00', 2, '13.00', '', 'Diario', '750.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(208, 42, 6, 7, 0, 1, '13.00', '850.00', 1, '13.00', '', 'Diario', '850.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(209, 42, 91, 106, 0, 1, '13.00', '5000.00', 1, '13.00', '', 'Programas', '5000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(210, 42, 91, 95, 0, 1, '13.00', '2000.00', 1, '13.00', '', 'Diario', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(212, 42, 91, 96, 0, 1, '1.00', '5000.00', 1, '1.00', '', 'Global', '5000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(213, 42, 91, 96, 0, 1, '13.00', '2500.00', 1, '13.00', '', 'Diario', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(214, 42, 50, 56, 0, 1, '1.00', '17000.00', 1, '1.00', '', 'Mensual', '17000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(215, 42, 50, 56, 0, 1, '1.00', '13500.00', 1, '1.00', '', 'Mensual', '13500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(217, 42, 4, 88, 0, 1, '13.00', '2000.00', 1, '13.00', '', 'Programas', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(218, 42, 91, 92, 0, 1, '2.00', '3000.00', 1, '2.00', '', 'Global', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(219, 42, 60, 65, 0, 1, '1.00', '15000.00', 1, '1.00', '', 'Unidad', '15000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(220, 42, 50, 87, 0, 1, '1.00', '25000.00', 1, '1.00', '', 'Global', '25000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(221, 42, 16, 31, 0, 1, '1.00', '3000.00', 1, '1.00', '', 'Global', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(222, 42, 16, 99, 0, 1, '1.00', '3000.00', 1, '1.00', '', 'Global', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(223, 42, 16, 97, 0, 1, '2.00', '6000.00', 1, '2.00', '', 'Mensual', '6000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(224, 42, 16, 29, 0, 1, '1.00', '4000.00', 1, '1.00', '', 'Global', '4000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(225, 42, 75, 77, 0, 1, '1.00', '14500.00', 1, '1.00', '', 'Global', '14500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(226, 42, 4, 5, 0, 1, '1.00', '67450.00', 1, '1.00', '', 'Global', '67450.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(230, 43, 32, 17, 26, 1, '1.00', '7500.00', 1, '1.00', '', '', '0.00', 0, 0, '2014-07-01', '2014-07-08', 1, 'Iguales', 15),
(231, 43, 42, 43, 12, 1, '1.00', '4200.00', 1, '1.00', '', '', '3000.00', 0, 0, '2014-07-01', '2014-07-08', 1, 'Iguales', 15),
(233, 38, 91, 116, 0, 0, '0.00', '0.00', 0, '0.00', '', 'Unidad', '0.00', 0, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(234, 44, 32, 17, 39, 1, '3.00', '19000.00', 1, '3.00', '', '', '19000.00', 0, 0, '2014-09-01', '2014-11-30', 3, 'Iguales', 18),
(235, 44, 38, 40, 40, 1, '3.00', '16520.00', 1, '3.00', '', '', '16520.00', 0, 0, '2014-09-01', '2014-11-30', 3, 'Iguales', 18),
(236, 44, 6, 82, 40, 1, '3.00', '8400.00', 1, '3.00', '', 'Unidad', '8400.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(237, 44, 6, 84, 0, 1, '3.00', '1680.00', 1, '3.00', '', 'Global', '1680.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(238, 44, 6, 7, 0, 1, '3.00', '2100.00', 1, '3.00', '', 'Unidad', '2100.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(239, 44, 6, 85, 40, 1, '3.00', '20000.00', 1, '3.00', '', 'Unidad', '20000.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(240, 44, 50, 56, 40, 1, '3.00', '9100.00', 1, '3.00', '', 'Unidad', '9100.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(241, 44, 60, 63, 0, 1, '3.00', '3000.00', 1, '3.00', '', 'Unidad', '3000.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(242, 44, 60, 83, 0, 1, '3.00', '6000.00', 1, '3.00', '', 'Unidad', '6000.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(243, 44, 60, 86, 0, 1, '3.00', '1600.00', 1, '3.00', '', 'Unidad', '1600.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(244, 44, 60, 102, 0, 1, '3.00', '6000.00', 1, '3.00', '', 'Unidad', '6000.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(245, 44, 50, 87, 0, 1, '3.00', '4500.00', 1, '3.00', '', 'Unidad', '4500.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(246, 44, 4, 5, 40, 1, '18.00', '500.00', 1, '18.00', '', 'Unidad', '500.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(247, 44, 4, 88, 0, 1, '9.00', '250.00', 1, '9.00', '', 'Unidad', '250.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(248, 44, 4, 11, 40, 1, '3.00', '600.00', 1, '3.00', '', 'Unidad', '600.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(249, 44, 89, 90, 40, 1, '3.00', '1200.00', 1, '3.00', '', 'Unidad', '1200.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(250, 44, 91, 92, 0, 1, '3.00', '10000.00', 1, '3.00', '', 'Unidad', '10000.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(251, 44, 91, 95, 40, 1, '3.00', '3500.00', 1, '3.00', '', 'Mensual', '3500.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(252, 44, 16, 97, 40, 1, '3.00', '2500.00', 1, '3.00', '', 'Unidad', '2500.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(253, 44, 16, 99, 40, 1, '3.00', '1200.00', 1, '3.00', '', 'Unidad', '1200.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(254, 44, 16, 100, 40, 1, '3.00', '2000.00', 1, '3.00', '', 'Unidad', '2000.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(255, 44, 75, 76, 42, 1, '3.00', '1200.00', 1, '3.00', '', 'Unidad', '1200.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(256, 44, 75, 77, 0, 1, '3.00', '900.00', 1, '3.00', '', 'Unidad', '900.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(257, 44, 16, 31, 40, 1, '3.00', '1294.00', 1, '3.00', '', 'Unidad', '1294.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(258, 44, 91, 96, 40, 1, '3.00', '3000.00', 1, '3.00', '', 'Unidad', '3000.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(259, 44, 38, 41, 40, 1, '0.00', '0.00', 1, '0.00', '', 'Unidad', '0.00', 0, 0, '2014-09-01', '2014-11-30', 0, '', 18),
(260, 44, 6, 85, 41, 1, '0.00', '0.00', 1, '1.00', '', '', '1845.00', 0, 0, '2014-08-01', '2014-08-31', 1, 'Iguales', 18),
(261, 44, 91, 116, 0, 0, '0.00', '0.00', 0, '1.00', '', '', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(262, 45, 16, 97, 29, 2, '1.00', '1000.00', 2, '1.00', '', '', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 2, 'Iguales', 12),
(263, 45, 16, 29, 43, 1, '1.00', '15000.00', 1, '1.00', '', '', '15000.00', 0, 0, '0000-00-00', '0000-00-00', 4, 'Iguales', 1),
(264, 45, 4, 5, 22, 1, '1.00', '2222.00', 1, '1.00', '', '', '2222.00', 0, 0, '0000-00-00', '0000-00-00', 5, 'Iguales', 1),
(267, 46, 115, 119, 50, 1, '1.00', '0.00', 1, '1.00', '', '', '12000.00', 0, 0, '2014-09-08', '2014-08-28', 1, 'Iguales', 18),
(266, 46, 32, 118, 12, 1, '1.00', '20000.00', 1, '1.00', '', '', '11000.00', 0, 0, '2014-08-04', '2014-08-28', 1, 'Iguales', 18),
(268, 43, 115, 119, 52, 1, '1.00', '6500.00', 1, '1.00', '', '', '5000.00', 0, 0, '2014-07-07', '2014-07-15', 1, 'Iguales', 15),
(269, 43, 115, 121, 0, 1, '1.00', '2500.00', 1, '1.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(270, 43, 115, 120, 53, 1, '1.00', '2500.00', 1, '1.00', '', '', '1500.00', 0, 0, '2014-07-07', '2014-07-11', 1, 'Iguales', 15),
(271, 43, 50, 52, 56, 1, '1.00', '7500.00', 1, '1.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(272, 43, 50, 53, 54, 1, '1.00', '11500.00', 1, '1.00', '', '', '2500.00', 0, 0, '2014-07-10', '2014-07-15', 1, 'Iguales', 15),
(273, 43, 50, 56, 57, 1, '1.00', '7000.00', 1, '1.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(274, 43, 18, 57, 0, 1, '1.00', '1800.00', 1, '1.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(275, 43, 18, 58, 0, 1, '1.00', '7500.00', 1, '1.00', '', '', '5500.00', 0, 0, '2014-07-09', '2014-07-09', 1, 'Iguales', 15),
(277, 43, 60, 63, 25, 1, '1.00', '3500.00', 1, '1.00', '', '', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 15),
(278, 43, 60, 64, 25, 1, '1.00', '1200.00', 1, '1.00', '', '', '600.00', 0, 0, '2014-09-09', '0000-00-00', 1, 'Iguales', 15),
(279, 43, 60, 65, 55, 1, '1.00', '10000.00', 1, '1.00', '', '', '10000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 15),
(280, 43, 66, 67, 0, 1, '1.00', '90.00', 1, '1.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(282, 43, 66, 68, 0, 1, '2.00', '8.00', 1, '1.00', '', '', '40.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 15),
(283, 43, 75, 77, 42, 1, '1.00', '400.00', 1, '1.00', '', '', '250.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(284, 43, 75, 78, 0, 1, '1.00', '350.00', 1, '1.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(285, 43, 18, 74, 0, 1, '1.00', '558.00', 1, '1.00', '', '', '312.00', 0, 0, '2014-07-09', '2014-07-09', 1, 'Iguales', 15),
(286, 43, 75, 76, 42, 1, '1.00', '300.00', 1, '1.00', '', '', '380.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(287, 49, 42, 43, 29, 1, '3.00', '5000.00', 1, '3.00', '', '', '5000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 15),
(288, 49, 115, 119, 0, 1, '3.00', '4500.00', 1, '3.00', '', 'Unidad', '4500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(289, 49, 115, 120, 0, 1, '3.00', '2500.00', 1, '3.00', '', 'Unidad', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(290, 49, 38, 40, 0, 1, '3.00', '2000.00', 1, '3.00', '', 'Unidad', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(291, 49, 50, 53, 0, 1, '1.00', '13000.00', 1, '1.00', '', 'Global', '13000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(292, 49, 50, 56, 0, 1, '1.00', '3250.00', 1, '1.00', '', 'Global', '3250.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(293, 49, 18, 58, 0, 1, '1.00', '12000.00', 1, '1.00', '', 'Global', '12000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(294, 49, 18, 74, 0, 1, '1.00', '720.00', 1, '1.00', '', 'Global', '720.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(295, 49, 60, 86, 0, 1, '3.00', '750.00', 1, '3.00', '', 'Global', '750.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(296, 49, 60, 63, 0, 1, '3.00', '1300.00', 1, '3.00', '', 'Unidad', '1300.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(297, 49, 60, 102, 0, 1, '1.00', '7000.00', 1, '1.00', '', 'Unidad', '7000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(298, 49, 66, 67, 0, 1, '1.00', '180.00', 1, '1.00', '', 'Unidad', '180.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(299, 49, 66, 68, 0, 1, '6.00', '8.00', 1, '6.00', '', 'Unidad', '8.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(300, 49, 75, 76, 0, 1, '1.00', '800.00', 1, '1.00', '', 'Unidad', '800.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(301, 49, 75, 77, 0, 1, '1.00', '800.00', 1, '1.00', '', 'Unidad', '800.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(302, 49, 75, 78, 0, 1, '1.00', '750.00', 1, '1.00', '', 'Unidad', '750.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 15),
(304, 30, 42, 44, 29, 1, '1.00', '100.00', 1, '1.00', '', 'Unidad', '100.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 12),
(309, 30, 6, 82, 29, 1, '1.00', '5000.00', 1, '1.00', '', 'Unidad', '5000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 12),
(311, 30, 6, 82, 29, 1, '1.00', '1000.00', 1, '1.00', '', 'Mensual', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(312, 30, 60, 65, 55, 1, '10.00', '40000.00', 1, '10.00', '', 'Programas', '40000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(313, 51, 32, 33, 39, 1, '1.00', '20000.00', 1, '1.00', '', '', '20000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 18),
(314, 51, 38, 41, 58, 1, '1.00', '4000.00', 1, '1.00', '', '', '4000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 18),
(315, 51, 38, 40, 0, 1, '1.00', '6000.00', 1, '1.00', '', '', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 18),
(316, 51, 6, 82, 0, 1, '3.00', '1350.00', 1, '2.00', '', '', '1350.00', 0, 0, '2015-05-04', '2015-06-18', 1, 'Iguales', 18),
(317, 51, 6, 84, 0, 1, '3.00', '850.00', 1, '3.00', '', 'Diario', '850.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(318, 51, 50, 56, 23, 1, '1.00', '6000.00', 1, '1.00', '', '', '4000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 18),
(319, 51, 60, 63, 25, 1, '1.00', '2500.00', 1, '1.00', '', '', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 18),
(321, 51, 60, 86, 0, 1, '1.00', '400.00', 1, '1.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 18),
(322, 51, 60, 83, 59, 1, '1.00', '4500.00', 1, '1.00', '', '', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 18),
(323, 51, 60, 102, 0, 1, '1.00', '500.00', 1, '1.00', '', 'Global', '500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(324, 51, 50, 87, 52, 1, '1.00', '35000.00', 1, '1.00', '', '', '32000.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 18),
(325, 51, 4, 5, 0, 1, '3.00', '500.00', 1, '2.00', '', '', '500.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 18),
(326, 51, 4, 88, 0, 1, '2.00', '250.00', 1, '2.00', '', 'Diario', '250.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(327, 51, 4, 125, 0, 1, '1.00', '10000.00', 1, '1.00', '', '', '10018.00', 0, 0, '2015-06-01', '2015-06-04', 1, 'Iguales', 18),
(328, 51, 89, 90, 0, 1, '1.00', '1000.00', 1, '1.00', '', '', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 18),
(329, 51, 91, 95, 0, 1, '1.00', '3000.00', 1, '1.00', '', 'Global', '3000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(330, 51, 91, 96, 0, 1, '1.00', '4000.00', 1, '1.00', '', 'Global', '4000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(331, 51, 16, 31, 0, 1, '1.00', '1200.00', 1, '1.00', '', 'Mensual', '1200.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(332, 51, 16, 97, 0, 1, '1.00', '2500.00', 1, '1.00', '', 'Mensual', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(333, 51, 16, 99, 0, 1, '1.00', '1200.00', 1, '1.00', '', '', '1200.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(334, 51, 16, 100, 0, 1, '1.00', '2500.00', 1, '1.00', '', '', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(335, 51, 75, 76, 42, 1, '1.00', '400.00', 1, '1.00', '', '', '900.00', 0, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 18),
(336, 51, 75, 77, 0, 1, '1.00', '900.00', 1, '1.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 18),
(337, 51, 127, 128, 0, 0, '0.00', '0.00', 0, '1.00', '', '', '960.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(338, 52, 32, 17, 39, 1, '1.00', '20000.00', 1, '1.00', '', 'Unidad', '20000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(342, 52, 18, 112, 0, 1, '1.00', '12000.00', 1, '1.00', '', '', '12000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(340, 52, 38, 41, 0, 1, '1.00', '9500.00', 1, '1.00', '', '', '9500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(341, 52, 38, 129, 0, 1, '1.00', '4000.00', 1, '1.00', '', 'Unidad', '4000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(343, 52, 18, 26, 0, 1, '1.00', '5300.00', 1, '1.00', '', '', '5300.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(344, 52, 91, 131, 0, 1, '1.00', '11500.00', 1, '1.00', '', '', '11500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(345, 52, 50, 56, 0, 0, '0.00', '0.00', 0, '0.00', '', '', '0.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(346, 52, 50, 56, 0, 1, '1.00', '8000.00', 1, '1.00', '', 'Mensual', '8000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(347, 52, 50, 56, 0, 1, '1.00', '8000.00', 1, '1.00', '', 'Mensual', '8000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(357, 52, 4, 5, 0, 1, '3.00', '1200.00', 1, '3.00', '', 'Unidad', '1200.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(355, 52, 60, 102, 0, 1, '1.00', '600.00', 1, '1.00', '', '', '600.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(350, 52, 60, 63, 0, 2, '1.00', '2500.00', 2, '1.00', '', 'Unidad', '2500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(351, 52, 60, 86, 0, 1, '1.00', '400.00', 1, '1.00', '', '', '400.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(354, 52, 60, 83, 0, 1, '1.00', '4000.00', 1, '1.00', '', '', '4000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(356, 52, 50, 87, 0, 1, '1.00', '20000.00', 1, '1.00', '', '', '20000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(358, 52, 4, 8, 0, 1, '3.00', '1500.00', 1, '3.00', '', '', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(359, 52, 66, 132, 0, 1, '1.00', '2000.00', 1, '1.00', '', '', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(360, 52, 66, 69, 0, 1, '1.00', '2000.00', 1, '1.00', '', '', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(361, 52, 91, 95, 0, 1, '1.00', '4000.00', 1, '1.00', '', '', '4000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(362, 52, 91, 96, 0, 1, '1.00', '6000.00', 1, '1.00', '', '', '6000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(363, 52, 16, 31, 0, 1, '1.00', '1000.00', 1, '1.00', '', '', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(364, 52, 16, 100, 0, 1, '1.00', '1200.00', 1, '1.00', '', 'Unidad', '1200.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(365, 52, 16, 99, 0, 1, '1.00', '1000.00', 1, '1.00', '', '', '1000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(366, 52, 16, 97, 0, 1, '1.00', '1500.00', 1, '1.00', '', '', '1500.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(367, 54, 42, 7, 40, 100, '100.00', '1212.00', 100, '100.00', '', 'Unidad', '1212.00', 10, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(368, 54, 42, 7, 24, 1, '100.00', '12.00', 1, '100.00', '', 'Mensual', '12.00', 10, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(369, 52, 42, 7, 34, 12, '12.00', '12.00', 12, '12.00', '', 'Unidad', '12.00', 10, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(370, 52, 42, 7, 39, 1, '1.00', '1.00', 1, '1.00', '', 'Mensual', '1.00', 10, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(390, 58, 18, 74, 34, 1, '1.00', '100.00', 1, '1.00', '', 'Unidad', '100.00', 6, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(391, 58, 4, 5, 58, 2, '10.00', '2000.00', 2, '10.00', 'la lalalala', 'Diario', '2000.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(392, 58, 115, 119, 40, 1, '1.00', '111.00', 1, '1.00', 'wtstasdfasdf', 'Unidad', '111.00', 2, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(385, 55, 115, 122, 34, 1, '1.00', '1000.00', 1, '1.00', 'desc', 'Unidad', '1000.00', 4, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(386, 55, 115, 122, 40, 0, '0.00', '0.00', 0, '12.00', 'adfsasdf', '', '12.00', 0, 0, '0000-00-00', '0000-00-00', 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `project_resource_payments`
--

DROP TABLE IF EXISTS `project_resource_payments`;
CREATE TABLE `project_resource_payments` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `value` decimal(10,2) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_resource_payments`
--

INSERT INTO `project_resource_payments` (`id`, `project_id`, `resource_id`, `date`, `value`) VALUES
(1, 14, 8, '2014-07-16', '5000.00'),
(2, 14, 8, '2014-07-17', '5000.00'),
(3, 14, 8, '2014-07-18', '5000.00'),
(4, 14, 8, '2014-07-19', '5000.00'),
(5, 14, 8, '2014-07-20', '5000.00'),
(6, 14, 5, '2014-07-16', '2000.00'),
(7, 14, 5, '2014-07-17', '2000.00'),
(8, 14, 5, '2014-07-18', '2000.00'),
(9, 14, 5, '2014-07-19', '2000.00'),
(10, 14, 5, '2014-07-20', '2000.00'),
(11, 17, 5, '2014-07-16', '1200.00'),
(12, 34, 52, '2014-08-01', '2500.00'),
(19, 36, 112, '2014-08-19', '1400.00'),
(18, 36, 111, '2014-08-12', '3000.00'),
(17, 36, 111, '2014-08-11', '3000.00'),
(20, 36, 112, '2014-08-27', '1400.00'),
(21, 39, 194, '2014-08-02', '500.00'),
(22, 39, 194, '2014-08-04', '500.00'),
(23, 39, 195, '2014-08-13', '3750.00'),
(24, 39, 195, '2014-08-14', '3750.00'),
(25, 39, 195, '2014-08-15', '3750.00'),
(26, 39, 195, '2014-08-16', '3750.00'),
(27, 39, 196, '2014-08-21', '444.40'),
(28, 39, 196, '2014-08-22', '444.40'),
(29, 39, 196, '2014-08-23', '444.40'),
(30, 39, 196, '2014-08-24', '444.40'),
(31, 39, 196, '2014-08-25', '444.40'),
(32, 38, 176, '2014-09-05', '10511.00'),
(33, 38, 176, '2014-09-05', '10511.00'),
(34, 38, 149, '2014-09-05', '10500.00'),
(35, 38, 149, '2014-09-05', '10500.00'),
(36, 38, 149, '2014-09-05', '10500.00'),
(37, 38, 144, '2014-09-05', '19000.00'),
(38, 38, 145, '2014-09-05', '16520.00'),
(39, 38, 146, '2014-09-05', '16000.00'),
(40, 38, 177, '2014-09-05', '1844.00'),
(41, 38, 150, '2014-09-05', '9100.00'),
(42, 38, 144, '2014-09-05', '19000.00'),
(43, 46, 267, '2014-09-15', '12000.00'),
(44, 46, 266, '2014-09-26', '11000.00'),
(45, 43, 230, '2014-08-01', '3000.00'),
(46, 43, 231, '2014-08-01', '3000.00'),
(47, 43, 268, '2014-09-09', '5000.00'),
(48, 43, 270, '2014-08-11', '1500.00'),
(49, 43, 272, '2014-09-09', '2500.00'),
(50, 43, 275, '2014-07-21', '5500.00'),
(51, 43, 285, '2014-07-21', '312.00'),
(52, 43, 278, '2014-08-10', '300.00'),
(53, 43, 277, '2014-09-09', '3000.00'),
(54, 43, 277, '2014-09-09', '3000.00'),
(55, 43, 279, '2014-08-10', '10000.00'),
(56, 43, 282, '0000-00-00', '40.00'),
(57, 44, 234, '2014-10-06', '19000.00'),
(58, 44, 234, '2014-11-06', '19000.00'),
(59, 44, 234, '2014-12-08', '19000.00'),
(60, 44, 235, '2014-10-06', '16520.00'),
(61, 44, 235, '2014-11-05', '16520.00'),
(62, 44, 235, '2014-12-05', '16520.00'),
(63, 38, 147, '2015-04-27', '1680.00'),
(64, 51, 313, '2015-07-08', '20000.00'),
(65, 51, 314, '2015-07-07', '4000.00'),
(66, 51, 315, '2015-06-30', '3000.00'),
(67, 51, 315, '2015-06-30', '3000.00'),
(68, 51, 319, '2015-07-15', '3000.00'),
(69, 51, 322, '2015-06-30', '3000.00'),
(70, 51, 324, '2015-07-30', '32000.00'),
(71, 51, 327, '2015-07-07', '10018.00'),
(72, 51, 316, '2015-06-05', '2700.00'),
(73, 51, 336, '2015-05-13', '960.00');

-- --------------------------------------------------------

--
-- Table structure for table `project_rubro`
--

DROP TABLE IF EXISTS `project_rubro`;
CREATE TABLE `project_rubro` (
  `project_id` int(11) NOT NULL,
  `rubro_id` int(11) NOT NULL,
  `state` int(1) NOT NULL,
  `position` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_rubro`
--

INSERT INTO `project_rubro` (`project_id`, `rubro_id`, `state`, `position`) VALUES
(10, 17, 0, 0),
(10, 4, 0, 0),
(9, 4, 0, 0),
(12, 4, 0, 0),
(14, 4, 0, 0),
(14, 32, 0, 0),
(17, 4, 0, 0),
(22, 4, 0, 0),
(13, 4, 0, 0),
(26, 4, 0, 0),
(27, 4, 0, 0),
(28, 4, 0, 0),
(28, 42, 0, 0),
(29, 4, 0, 0),
(29, 42, 0, 0),
(31, 4, 0, 0),
(32, 4, 0, 0),
(30, 4, 0, 0),
(33, 4, 0, 0),
(33, 17, 0, 0),
(33, 38, 0, 0),
(33, 42, 0, 0),
(34, 50, 0, 0),
(34, 42, 0, 0),
(35, 4, 0, 0),
(34, 18, 0, 0),
(34, 60, 0, 0),
(34, 66, 0, 0),
(34, 75, 0, 0),
(34, 17, 0, 0),
(33, 50, 0, 0),
(36, 32, 0, 0),
(36, 38, 0, 0),
(36, 50, 0, 0),
(36, 60, 0, 0),
(36, 42, 0, 0),
(36, 66, 0, 0),
(36, 18, 0, 0),
(36, 75, 0, 0),
(36, 16, 0, 0),
(37, 32, 0, 0),
(37, 38, 0, 0),
(37, 50, 0, 0),
(37, 60, 0, 0),
(37, 42, 0, 0),
(37, 66, 0, 0),
(37, 18, 0, 0),
(37, 75, 0, 0),
(37, 16, 0, 0),
(39, 16, 0, 0),
(38, 32, 0, 0),
(33, 6, 0, 0),
(38, 38, 0, 0),
(38, 6, 0, 0),
(38, 50, 0, 0),
(38, 60, 0, 0),
(38, 4, 0, 0),
(38, 89, 0, 0),
(38, 91, 0, 0),
(38, 16, 0, 0),
(38, 75, 0, 0),
(33, 89, 0, 0),
(33, 60, 0, 0),
(33, 16, 0, 0),
(33, 75, 0, 0),
(33, 66, 0, 0),
(33, 91, 0, 0),
(33, 18, 0, 0),
(39, 4, 0, 0),
(41, 16, 0, 0),
(42, 42, 0, 0),
(42, 32, 0, 0),
(42, 38, 0, 0),
(42, 6, 0, 0),
(42, 91, 0, 0),
(42, 50, 0, 0),
(42, 4, 0, 0),
(42, 60, 0, 0),
(42, 16, 0, 0),
(42, 75, 0, 0),
(43, 32, 0, 0),
(43, 42, 0, 0),
(44, 32, 0, 1),
(44, 38, 0, 8),
(44, 6, 0, 7),
(44, 50, 0, 6),
(44, 60, 0, 5),
(44, 4, 0, 4),
(44, 89, 0, 3),
(44, 91, 0, 0),
(44, 16, 0, 2),
(44, 75, 0, 9),
(45, 16, 0, 0),
(45, 4, 0, 0),
(46, 115, 0, 0),
(46, 32, 0, 0),
(43, 115, 0, 0),
(43, 50, 0, 0),
(43, 18, 0, 0),
(43, 60, 0, 0),
(43, 66, 0, 0),
(43, 75, 0, 0),
(49, 42, 0, 0),
(49, 115, 0, 1),
(49, 38, 0, 2),
(49, 50, 0, 3),
(49, 18, 0, 4),
(49, 60, 0, 5),
(49, 66, 0, 6),
(49, 75, 0, 7),
(30, 42, 0, 0),
(30, 6, 0, 0),
(30, 60, 0, 0),
(51, 32, 0, 0),
(51, 38, 0, 1),
(51, 6, 0, 8),
(51, 50, 0, 7),
(51, 60, 0, 6),
(51, 4, 0, 5),
(51, 89, 0, 3),
(51, 91, 0, 2),
(51, 16, 0, 4),
(51, 75, 0, 9),
(51, 127, 0, 0),
(52, 32, 0, 0),
(52, 38, 0, 0),
(52, 18, 0, 0),
(52, 91, 0, 0),
(52, 50, 0, 0),
(52, 60, 0, 0),
(52, 4, 0, 0),
(52, 66, 0, 0),
(52, 16, 0, 0),
(54, 42, 0, 0),
(52, 42, 0, 0),
(58, 18, 0, 0),
(55, 115, 0, 0),
(58, 4, 0, 0),
(58, 115, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `project_subrubro`
--

DROP TABLE IF EXISTS `project_subrubro`;
CREATE TABLE `project_subrubro` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `rubro_id` int(11) NOT NULL,
  `subrubro_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL DEFAULT '0',
  `estimate_quantity` int(11) NOT NULL DEFAULT '0',
  `estimate_cost` decimal(15,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `concept` varchar(100) NOT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  `state` int(1) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `payments` int(11) NOT NULL,
  `payment_type` varchar(100) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_subrubro`
--

INSERT INTO `project_subrubro` (`id`, `project_id`, `rubro_id`, `subrubro_id`, `provider_id`, `estimate_quantity`, `estimate_cost`, `quantity`, `description`, `concept`, `cost`, `state`, `start_date`, `end_date`, `payments`, `payment_type`) VALUES
(6, 10, 4, 8, 0, 0, '0.00', 10, 'Descripción de la factura', 'Mensual', '200.00', 0, '0000-00-00', '0000-00-00', 0, ''),
(7, 10, 4, 5, 0, 0, '0.00', 10, 'test222\r\n', 'Unidad', '200.00', 0, '0000-00-00', '0000-00-00', 3, 'Iguales'),
(12, 10, 17, 28, 0, 0, '0.00', 60, 'Pago al Director', 'Diario', '25000.00', 0, '2014-07-10', '2014-07-31', 60, 'Iguales'),
(13, 10, 4, 14, 0, 0, '0.00', 10, '', 'Programas', '200.00', 0, '2014-07-11', '2014-07-12', 2, 'Iguales'),
(14, 9, 4, 5, 0, 0, '0.00', 10, 'test', 'Unidad', '1000.00', 0, '2014-07-11', '2014-07-11', 3, 'Diferentes'),
(15, 12, 4, 5, 0, 0, '0.00', 1, '', 'Unidad', '1000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(21, 14, 4, 8, 0, 0, '0.00', 5, '', 'Unidad', '1000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(23, 14, 4, 11, 0, 0, '0.00', 1, '', 'Unidad', '15500.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(22, 14, 4, 8, 0, 0, '0.00', 5, '', 'Unidad', '1000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(20, 14, 4, 5, 0, 0, '0.00', 2, 'Alquiler de Cámaras', 'Unidad', '5000.00', 0, '2014-07-16', '2014-07-31', 10, 'Iguales'),
(24, 14, 4, 9, 0, 0, '0.00', 2, '', 'Unidad', '25000.00', 0, '1901-01-01', '1901-01-31', 1, 'Iguales'),
(25, 14, 32, 36, 0, 0, '0.00', 1, '', 'Unidad', '50000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(26, 14, 32, 37, 0, 0, '0.00', 1, '', 'Unidad', '30000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(27, 14, 32, 33, 0, 0, '0.00', 1, '', 'Unidad', '50000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(28, 17, 4, 5, 0, 0, '0.00', 12, 'desc', 'Mensual', '100.00', 0, '2014-07-16', '2014-07-31', 1, 'Iguales'),
(29, 22, 4, 5, 0, 0, '0.00', 1, '', 'Unidad', '1500.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(30, 22, 4, 8, 0, 0, '0.00', 1, '', 'Unidad', '2000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(31, 22, 4, 11, 0, 0, '0.00', 1, '', 'Unidad', '3000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(32, 25, 4, 5, 0, 0, '0.00', 1, '', 'Unidad', '1500.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(33, 25, 4, 8, 0, 0, '0.00', 1, '', 'Unidad', '2000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(34, 25, 4, 11, 0, 0, '0.00', 1, '', 'Unidad', '3000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(35, 13, 4, 5, 0, 0, '0.00', 10, '', 'Mensual', '25000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(36, 13, 4, 8, 0, 0, '0.00', 1, '', 'Unidad', '100.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(37, 13, 4, 13, 0, 0, '0.00', 2, '', 'Unidad', '100.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(41, 27, 4, 8, 0, 0, '0.00', 1, '', 'Unidad', '100.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(39, 26, 4, 8, 0, 1, '1000.00', 0, '', 'Unidad', '0.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(40, 26, 4, 13, 0, 2, '500.00', 0, '', 'Unidad', '0.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(42, 27, 4, 13, 0, 0, '0.00', 2, '', 'Unidad', '100.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(47, 28, 4, 5, 0, 1, '1000.00', 2, '', 'Unidad', '1000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(48, 28, 4, 8, 0, 1, '1000.00', 1, '', 'Unidad', '1000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(49, 28, 42, 44, 0, 1, '222.00', 1, '', 'Unidad', '222.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(50, 28, 42, 43, 0, 2, '1000.00', 2, '', 'Unidad', '1000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(51, 29, 4, 5, 10, 1, '1500.00', 2, '', 'Unidad', '1300.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(52, 29, 42, 44, 0, 1, '1000.00', 1, '', 'Unidad', '800.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(53, 29, 4, 8, 11, 10, '1000.00', 9, 'Luces Ambientales', 'Unidad', '1000.00', 0, '2014-07-01', '2014-07-10', 1, 'Iguales'),
(54, 29, 4, 11, 7, 1, '1000.00', 2, '', 'Unidad', '1000.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(55, 29, 4, 14, 7, 2, '13.00', 3, 'test', 'Unidad', '13.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales'),
(56, 31, 4, 8, 9, 0, '0.00', 0, '', 'Unidad', '0.00', 0, '0000-00-00', '0000-00-00', 1, 'Iguales');

-- --------------------------------------------------------

--
-- Table structure for table `project_subrubro_payments`
--

DROP TABLE IF EXISTS `project_subrubro_payments`;
CREATE TABLE `project_subrubro_payments` (
  `project_id` int(11) NOT NULL,
  `subrubro_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `value` decimal(10,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_subrubro_payments`
--

INSERT INTO `project_subrubro_payments` (`project_id`, `subrubro_id`, `date`, `value`) VALUES
(14, 8, '2014-07-16', '5000.00'),
(14, 8, '2014-07-17', '5000.00'),
(14, 8, '2014-07-18', '5000.00'),
(14, 8, '2014-07-19', '5000.00'),
(14, 8, '2014-07-20', '5000.00'),
(14, 5, '2014-07-16', '2000.00'),
(14, 5, '2014-07-17', '2000.00'),
(14, 5, '2014-07-18', '2000.00'),
(14, 5, '2014-07-19', '2000.00'),
(14, 5, '2014-07-20', '2000.00'),
(17, 5, '2014-07-16', '1200.00');

-- --------------------------------------------------------

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
CREATE TABLE `provider` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `shorttitle` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `cuit` varchar(100) DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `rubro_id` int(11) NOT NULL,
  `subrubro_id` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  `creation_userid` int(11) NOT NULL,
  `modification_date` datetime NOT NULL,
  `modification_userid` int(11) DEFAULT NULL,
  `state` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `provider`
--

INSERT INTO `provider` (`id`, `title`, `shorttitle`, `description`, `cuit`, `category`, `phone`, `address`, `email`, `website`, `rubro_id`, `subrubro_id`, `creation_date`, `creation_userid`, `modification_date`, `modification_userid`, `state`) VALUES
(19, 'Joaquin Mustafa Torres ', 'joaquin-mustafa-torres-', '', '', '', '', '', '', '', 0, 0, '2014-07-31 16:05:57', 0, '0000-00-00 00:00:00', NULL, 0),
(20, 'REYES, Facundo', 'reyes-facundo', '', '20301829060', 'Inscripto', '', '', '', '', 0, 0, '2014-07-31 16:06:16', 0, '0000-00-00 00:00:00', NULL, 1),
(15, 'Raimundo Moujan', 'raimundo-moujan', '', '', '', '1133721370', '', '', '', 0, 0, '2014-07-31 15:48:00', 0, '0000-00-00 00:00:00', NULL, 0),
(40, 'El Perro en la Luna SRL', 'el-perro-en-la-luna-srl', '', '30-71047810-0', '', '47805657', 'O´Higgins 2653', 'info@elperroenlaluna.com.ar', '', 0, 0, '2014-08-08 14:40:56', 0, '0000-00-00 00:00:00', NULL, 1),
(14, 'Martin Rodriguez', 'martin-rodriguez', '', '', '', '1160221409', '', 'mateofederal@hotmail.com', '', 0, 0, '2014-07-31 15:39:51', 0, '0000-00-00 00:00:00', NULL, 0),
(12, 'Fernando Salem', 'fernando-salem', '', '20254363058', '', '', '', '', '', 0, 0, '2014-07-30 20:37:01', 0, '0000-00-00 00:00:00', NULL, 1),
(21, 'Georgina Pretto', 'georgina-pretto', '', '', '', '', '', '', '', 0, 0, '2014-07-31 16:06:35', 0, '0000-00-00 00:00:00', NULL, 0),
(22, 'Berenice Arguello', 'berenice-arguello', '', '', '', '', '', '', '', 0, 0, '2014-07-31 16:06:53', 0, '0000-00-00 00:00:00', NULL, 1),
(23, 'Leandro Ferrer ', 'leandro-ferrer-', '', '', '', '', '', '', '', 0, 0, '2014-07-31 16:07:18', 0, '0000-00-00 00:00:00', NULL, 0),
(24, 'Claudio Pedreira', 'claudio-pedreira', '', '', '', '', '', '', '', 0, 0, '2014-07-31 16:07:51', 0, '0000-00-00 00:00:00', NULL, 1),
(25, 'Rayuela ', 'rayuela-', '', '', '', '', '', '', '', 0, 0, '2014-07-31 16:08:00', 0, '0000-00-00 00:00:00', NULL, 0),
(26, 'Tomas Ambranson', 'tomas-ambranson', '', '', '', '', '', '', '', 0, 0, '2014-07-31 16:13:36', 0, '0000-00-00 00:00:00', NULL, 1),
(53, 'Ismael Mon', 'ismael-mon', '', '', 'Inscripto', '', '', '', '', 0, 0, '2014-09-09 16:13:45', 0, '0000-00-00 00:00:00', NULL, 0),
(29, 'NALLIM Jorge Adrian', 'nallim-jorge-adrian', '', '23246466319', 'Monotributista', '', '', '', '', 0, 0, '2014-08-01 09:50:27', 0, '0000-00-00 00:00:00', NULL, 1),
(30, 'Raimundo Moujan', 'raimundo-moujan', '', '', '', '', '', '', '', 0, 0, '2014-08-01 09:56:03', 0, '0000-00-00 00:00:00', NULL, 0),
(39, 'Fernando Mollica', 'fernando-mollica', '', '20-20282094-9', '', '154423-3556', 'O´Higgins 2653', 'fmollica@gmail.com', '', 0, 0, '2014-08-08 12:04:57', 0, '0000-00-00 00:00:00', NULL, 0),
(34, 'Alucine ', 'alucine-', '', '', '', '', '', '', '', 0, 0, '2014-08-01 10:06:41', 0, '0000-00-00 00:00:00', NULL, 1),
(41, 'Jorge Gabriel Tristan', 'jorge-gabriel-tristan', '', '20268499548', '', '1530368615', 'Deheza 2916', 'tallerbuenoscanos@gmail.com', '', 0, 0, '2014-08-08 15:19:32', 0, '0000-00-00 00:00:00', NULL, 0),
(42, 'Segurfilms', 'segurfilms', '', '', '', '4633-3405', 'Felipe Vallese 1751 ', 'segurfilms@gmail.com', 'www.segurfilms.com.ar', 0, 0, '2014-08-08 16:21:37', 0, '0000-00-00 00:00:00', NULL, 0),
(43, 'Alta Definición', 'alta-definicion', 'Esta es la descripcion', '', 'Inscripto', '', '', '', '', 0, 0, '2014-08-09 19:46:27', 0, '0000-00-00 00:00:00', NULL, 1),
(44, 'Leandro Piccarreta', 'leandro-piccarreta', '', '', '', '', '', '', '', 0, 0, '2014-08-09 19:46:58', 0, '0000-00-00 00:00:00', NULL, 0),
(45, 'TAGO', 'tago', '', '', '', '', '', '', '', 0, 0, '2014-08-09 19:47:15', 0, '0000-00-00 00:00:00', NULL, 0),
(46, 'Fianzas y Crédito', 'fianzas-y-credito', '', '', '', '', '', '', '', 0, 0, '2014-08-09 19:47:37', 0, '0000-00-00 00:00:00', NULL, 0),
(50, 'Mercedes Maria Garcia Frinchaboy', 'mercedes-maria-garcia-frinchaboy', '', '27-31061511-6', 'Monotributista', '55959040', 'Arcos 1953', 'mekfrinchaboy@gmail.com', '', 0, 0, '2014-09-04 17:08:41', 0, '0000-00-00 00:00:00', NULL, 0),
(54, 'Nicolas Ortiz', 'nicolas-ortiz', '', '', 'Inscripto', '', '', '', '', 0, 0, '2014-09-09 16:14:36', 0, '0000-00-00 00:00:00', NULL, 0),
(49, 'Maria Mr', 'maria-mr', '', '', 'Inscripto', '', '', '', '', 0, 0, '2014-09-04 17:06:34', 0, '0000-00-00 00:00:00', NULL, 0),
(48, 'Telma Martin', 'telma-martin', '', '29-2020202-1', 'Monotributista', '48595095', 'olaya', 'gs@elperro.com.ar', '', 0, 0, '2014-09-04 11:59:39', 0, '0000-00-00 00:00:00', NULL, 1),
(52, 'Nicolas Dardano', 'nicolas-dardano', '', '', 'Inscripto', '', '', '', '', 0, 0, '2014-09-09 16:13:20', 0, '0000-00-00 00:00:00', NULL, 0),
(55, 'Sujatovich Leo', 'sujatovich-leo', '', '', 'Inscripto', '', '', '', '', 0, 0, '2014-09-09 16:27:31', 0, '0000-00-00 00:00:00', NULL, 0),
(56, 'Angeles Cornejo', 'angeles-cornejo', '', '', 'Inscripto', '', '', '', '', 0, 0, '2014-09-09 16:27:51', 0, '0000-00-00 00:00:00', NULL, 0),
(57, 'Angel Rodriguez', 'angel-rodriguez', '', '', 'Inscripto', '', '', '', '', 0, 0, '2014-09-09 16:28:32', 0, '0000-00-00 00:00:00', NULL, 0),
(58, 'Guido Speroni', 'guido-speroni', '', '', 'Inscripto', '', '', '', '', 0, 0, '2015-08-19 23:25:35', 0, '0000-00-00 00:00:00', NULL, 0),
(59, 'Leto Dugatkin', 'leto-dugatkin', '', '', 'Inscripto', '', '', '', '', 0, 0, '2015-08-19 23:33:54', 0, '0000-00-00 00:00:00', NULL, 0),
(60, 'SIERRA, Gonzalo', 'sierra-gonzalo', '', '20252573845', 'Monotributista', '', '', '', '', 0, 0, '2015-10-02 12:33:33', 0, '0000-00-00 00:00:00', NULL, 0),
(63, 'MANCINI, MPaula', 'mancini-mpaula', '', '27233290136', 'Inscripto', '', '', '', '', 0, 0, '2015-10-02 12:55:36', 0, '0000-00-00 00:00:00', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rubro`
--

DROP TABLE IF EXISTS `rubro`;
CREATE TABLE `rubro` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `sindicato_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `percentage` decimal(10,0) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rubro`
--

INSERT INTO `rubro` (`id`, `parent_id`, `sindicato_id`, `title`, `percentage`) VALUES
(105, 105, 0, 'Arte Rodaje ', '0'),
(4, 0, 0, 'Alquiler de Equipamiento', '0'),
(5, 4, 0, 'Alquiler de Camara', '0'),
(6, 0, 4, 'Personal Tecnico de Rodaje', '0'),
(7, 6, 0, 'Sonidista', '0'),
(8, 4, 0, 'Alquiler de Luces', '0'),
(9, 4, 0, 'Paquete Luces', '0'),
(10, 4, 0, 'Cámara y accesorios Canon EOS 5D', '0'),
(11, 4, 0, 'Carro o slider', '0'),
(12, 4, 0, 'Grip / Hot Head', '0'),
(13, 4, 0, 'Dolly Mini Jib', '0'),
(14, 4, 0, 'Flat Car', '0'),
(15, 0, 0, 'MATERIAL VIRGEN Y LABORATORIO', '0'),
(16, 0, 2, 'Administración y estructura', '0'),
(17, 32, 0, 'Honorarios director', '0'),
(18, 0, 0, 'MODELOS', '0'),
(19, 0, 0, 'NO SINDICADOS', '0'),
(20, 19, 0, 'coach de actores', '0'),
(21, 19, 0, 'coreografo', '0'),
(22, 19, 0, 'secundarios', '0'),
(23, 19, 0, 'Bailarina', '0'),
(24, 18, 0, 'Castinera', '0'),
(25, 18, 0, 'Personaje secundarios (jornada laboral + uso todos los medios)', '0'),
(26, 18, 0, 'Extras', '0'),
(27, 18, 0, 'Pruebas de Vestuario', '0'),
(28, 17, 0, 'Honorarios Director', '0'),
(29, 16, 0, 'Caja chica', '0'),
(30, 16, 0, 'Envios al Exterior', '0'),
(31, 16, 0, 'Telefonos y Faxes', '0'),
(32, 0, 0, 'DIRECCIÓN', '0'),
(33, 32, 0, 'Dirección General', '0'),
(34, 32, 0, 'Director U1', '0'),
(35, 32, 0, 'Director U2', '0'),
(36, 32, 0, 'Asistente de Dirección', '0'),
(37, 32, 0, 'Auxiliar de Dirección', '0'),
(38, 0, 0, 'PRODUCCIÓN', '0'),
(39, 38, 0, 'Productor General', '0'),
(40, 38, 4, 'Jefe de Producción', '0'),
(41, 38, 4, 'Asistente de Producción', '0'),
(42, 0, 0, 'CONTENIDOS', '0'),
(43, 42, 2, 'Guiones', '0'),
(44, 42, 0, 'Asesoramiento en Contenidos', '0'),
(83, 60, 0, 'Locutor', '0'),
(82, 6, 4, 'Camarógrafo ', '0'),
(49, 49, 0, 'Arte digital / Diseño ', '0'),
(50, 0, 0, 'Post producción', '0'),
(87, 50, 0, 'Diseño de placas / animaciones', '0'),
(52, 50, 0, 'Director de animación', '0'),
(53, 50, 0, 'Animadores', '0'),
(54, 50, 0, 'Data manager', '0'),
(55, 50, 0, 'Data manager', '0'),
(56, 50, 4, 'Editor', '0'),
(57, 18, 0, 'Direccion de voces', '0'),
(58, 18, 0, 'voces originales', '0'),
(59, 18, 0, 'voces originales', '0'),
(60, 0, 0, 'SONIDO', '0'),
(84, 6, 4, 'Asistente de cámara', '0'),
(63, 60, 0, 'Postproducción de sonido', '0'),
(64, 60, 0, 'Estudio de grabación de voces', '0'),
(65, 60, 0, 'Música original', '0'),
(66, 0, 0, 'Insumos', '0'),
(67, 66, 0, 'DVCAM', '0'),
(68, 66, 0, 'DVD', '0'),
(69, 66, 0, 'Bienes de uso', '0'),
(85, 6, 0, 'Grip', '0'),
(112, 18, 0, 'Actores', '0'),
(74, 18, 6, 'AAA', '0'),
(75, 0, 0, 'SEGUROS', '0'),
(76, 75, 0, 'Accidentes Personales', '0'),
(77, 75, 0, 'Seguro Equipos', '0'),
(78, 75, 0, 'Seguro Caución', '0'),
(79, 75, 0, 'Responsabilidad Civil', '0'),
(86, 60, 0, 'Estudio de grabación', '0'),
(88, 4, 0, 'Sonido', '0'),
(89, 0, 0, 'Bienes de uso', '0'),
(90, 89, 0, 'Sala de edición', '0'),
(91, 0, 0, 'Gastos de rodaje', '0'),
(92, 91, 0, 'Storage', '0'),
(93, 91, 0, 'Gelatinas y filtros', '0'),
(94, 91, 0, 'Alquiler Handies', '0'),
(95, 91, 0, 'Comidas', '0'),
(96, 91, 0, 'Movilidad', '0'),
(97, 16, 6, 'Auxiliar administrativa', '0'),
(99, 16, 0, 'Mensajeria', '0'),
(100, 16, 0, 'Servicios varios (alquiler, servicios, etc)', '0'),
(101, 66, 0, 'Material Virgen ', '0'),
(102, 60, 0, 'Musicalización', '0'),
(106, 91, 0, 'Utilería ', '0'),
(107, 91, 0, 'gastos de rodaje ', '0'),
(113, 113, 0, 'Director arte', '0'),
(115, 0, 9, 'ARTE', '0'),
(116, 91, 0, 'Gastos varios produccion', '0'),
(118, 32, 0, 'Director Creativo', '0'),
(119, 115, 9, 'dirección de arte', '0'),
(120, 115, 9, 'story board', '0'),
(121, 115, 9, 'diseño personajes y fondos', '0'),
(122, 115, 8, 'Ilustraciones', '0'),
(123, 115, 9, 'Ilustraciones', '0'),
(124, 75, 0, 'Accidentes Personales', '0'),
(126, 126, 0, 'Compra de material de archivo', '0'),
(125, 4, 0, 'Jornada de drone', '0'),
(127, 0, 0, 'Archivo', '0'),
(128, 127, 0, 'Compra de material de archivo', '0'),
(129, 38, 0, 'jefe de produccion ', '0'),
(130, 0, 0, 'locaciones', '0'),
(131, 91, 0, 'locaciones', '0'),
(132, 66, 0, 'Compra de disco externo', '0'),
(133, 42, 7, 'Editores', '0'),
(134, 97, 6, 'test sub sub rubro', '0'),
(135, 134, 5, 'another sub subrubro', '0'),
(136, 0, 0, 'SUPER RUBRO', '0');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `setting_name` varchar(100) NOT NULL,
  `setting_value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`setting_name`, `setting_value`) VALUES
('facturacion_anual', '12000000'),
('tipo_facturacion', 'manual');

-- --------------------------------------------------------

--
-- Table structure for table `sindicato`
--

DROP TABLE IF EXISTS `sindicato`;
CREATE TABLE `sindicato` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `percentage` varchar(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sindicato`
--

INSERT INTO `sindicato` (`id`, `name`, `percentage`) VALUES
(2, 'FATSA', '10'),
(4, 'SAT', '47'),
(5, 'SADAIC', '2'),
(6, 'AAA', '6'),
(7, 'Sindicato de Editores', '10'),
(8, 'Sindicato Audiovisual', '5'),
(9, 'Sindicato de Arte', '2');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(100) DEFAULT '',
  `user_pass` varchar(200) NOT NULL DEFAULT '0',
  `user_alias` varchar(30) DEFAULT '',
  `user_name` varchar(100) DEFAULT '',
  `user_lastname` varchar(100) DEFAULT '',
  `user_dateborn` date NOT NULL DEFAULT '0000-00-00',
  `user_documenttype` varchar(10) DEFAULT '',
  `user_document` varchar(10) DEFAULT '',
  `user_location` int(11) NOT NULL DEFAULT '0',
  `user_active` int(1) NOT NULL DEFAULT '0',
  `photo_id` int(1) NOT NULL DEFAULT '0',
  `mail_suscription` int(1) NOT NULL DEFAULT '1',
  `mail_response` int(1) NOT NULL DEFAULT '1',
  `mail_listas` int(1) NOT NULL DEFAULT '1',
  `user_migrado` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_admin`
--

DROP TABLE IF EXISTS `user_admin`;
CREATE TABLE `user_admin` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(100) DEFAULT '',
  `user_password` varchar(200) NOT NULL DEFAULT '0',
  `username` varchar(30) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT '',
  `user_lastname` varchar(100) DEFAULT '',
  `user_active` int(1) NOT NULL DEFAULT '0',
  `photo_id` int(1) NOT NULL DEFAULT '0',
  `access_level` int(1) NOT NULL DEFAULT '0',
  `site_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_admin`
--

INSERT INTO `user_admin` (`user_id`, `user_email`, `user_password`, `username`, `user_name`, `user_lastname`, `user_active`, `photo_id`, `access_level`, `site_id`) VALUES
(1, 'ariel@frooit.com', '6c7f6e6d6c797e736e7328', 'admin', 'Ariel', 'Velaz', 0, 0, 1, 1),
(11, 'dario@godaro.com', '666c686964787865797f', 'godaro', 'Dario', 'Aguilar', 0, 0, 1, 0),
(25, 'adrian@xxx.com', '3b3f3236303b3b', 'adrian', 'Adrian', 'Martin', 0, 0, 1, 0),
(13, 'javierF79@gmail.com', '7f7d516e6464606108', 'JavierF', 'Javier', 'Frontera', 0, 0, 1, 0),
(15, 'produccionzamba@gmail.com', '6f7d6d7b', 'zamba', 'Camila', 'Fanego', 0, 0, 1, 0),
(16, 'sm@elperroenlaluna.com.ar', '6f617167777f6476', 'ilvo', 'Sebastián ', 'Mignogna', 0, 0, 1, 0),
(18, 'gs@elperroenlaluna.com.ar', '3b3f323634', 'barca', 'gabriel', 'Siperman', 0, 0, 1, 0),
(19, 'eplproduccion@gmail.com', '3b3f323634', 'Silvia', 'Silvia', 'Lastra', 0, 0, 1, 0),
(26, 'valeria@raze.tv', '3b3f3236303b3c383231', 'Valeria', 'valeria', 'Gigli', 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_level`
--

DROP TABLE IF EXISTS `user_level`;
CREATE TABLE `user_level` (
  `user_level_id` int(11) NOT NULL,
  `user_level_name` varchar(100) NOT NULL DEFAULT '',
  `user_level_description` varchar(255) NOT NULL,
  `user_level_default_module` varchar(100) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_level`
--

INSERT INTO `user_level` (`user_level_id`, `user_level_name`, `user_level_description`, `user_level_default_module`) VALUES
(1, 'administrator', 'Super Admin', 'dashboard'),
(2, 'director', 'Director General', 'dashboard'),
(3, 'productor', 'Productor General', 'dashboard'),
(4, 'responsable', 'Responsable Proyecto', 'project'),
(5, 'asistente', 'Asistente', 'rubro'),
(6, 'administracion', 'Administración', 'dashboard');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cobro`
--
ALTER TABLE `cobro`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `costo_operativo`
--
ALTER TABLE `costo_operativo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `multimedia`
--
ALTER TABLE `multimedia`
  ADD PRIMARY KEY (`multimedia_id`),
  ADD FULLTEXT KEY `busqueda` (`multimedia_title`,`multimedia_content`,`object_custom`);

--
-- Indexes for table `multimedia_deleted`
--
ALTER TABLE `multimedia_deleted`
  ADD PRIMARY KEY (`multimedia_id`);

--
-- Indexes for table `object`
--
ALTER TABLE `object`
  ADD PRIMARY KEY (`object_id`),
  ADD FULLTEXT KEY `busqueda` (`object_title`,`object_content`,`object_custom`);

--
-- Indexes for table `object_deleted`
--
ALTER TABLE `object_deleted`
  ADD PRIMARY KEY (`object_id`),
  ADD FULLTEXT KEY `busqueda` (`object_title`,`object_content`,`object_custom`);

--
-- Indexes for table `object_type`
--
ALTER TABLE `object_type`
  ADD PRIMARY KEY (`object_typeid`);

--
-- Indexes for table `partida`
--
ALTER TABLE `partida`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_resource`
--
ALTER TABLE `project_resource`
  ADD PRIMARY KEY (`resource_id`);

--
-- Indexes for table `project_resource_payments`
--
ALTER TABLE `project_resource_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_subrubro`
--
ALTER TABLE `project_subrubro`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provider`
--
ALTER TABLE `provider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rubro`
--
ALTER TABLE `rubro`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_name`);

--
-- Indexes for table `sindicato`
--
ALTER TABLE `sindicato`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_admin`
--
ALTER TABLE `user_admin`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `alias` (`username`),
  ADD UNIQUE KEY `email` (`user_email`);

--
-- Indexes for table `user_level`
--
ALTER TABLE `user_level`
  ADD PRIMARY KEY (`user_level_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `cobro`
--
ALTER TABLE `cobro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `costo_operativo`
--
ALTER TABLE `costo_operativo`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=124;
--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2445;
--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `multimedia`
--
ALTER TABLE `multimedia`
  MODIFY `multimedia_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `multimedia_deleted`
--
ALTER TABLE `multimedia_deleted`
  MODIFY `multimedia_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `object`
--
ALTER TABLE `object`
  MODIFY `object_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=180;
--
-- AUTO_INCREMENT for table `object_deleted`
--
ALTER TABLE `object_deleted`
  MODIFY `object_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=180;
--
-- AUTO_INCREMENT for table `object_type`
--
ALTER TABLE `object_type`
  MODIFY `object_typeid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `partida`
--
ALTER TABLE `partida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `project_resource`
--
ALTER TABLE `project_resource`
  MODIFY `resource_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=393;
--
-- AUTO_INCREMENT for table `project_resource_payments`
--
ALTER TABLE `project_resource_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT for table `project_subrubro`
--
ALTER TABLE `project_subrubro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT for table `provider`
--
ALTER TABLE `provider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=64;
--
-- AUTO_INCREMENT for table `rubro`
--
ALTER TABLE `rubro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=137;
--
-- AUTO_INCREMENT for table `sindicato`
--
ALTER TABLE `sindicato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_admin`
--
ALTER TABLE `user_admin`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `user_level`
--
ALTER TABLE `user_level`
  MODIFY `user_level_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
