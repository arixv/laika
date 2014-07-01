-- phpMyAdmin SQL Dump
-- version 2.11.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 01, 2014 at 08:26 PM
-- Server version: 5.0.41
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mdn_laika`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` int(11) NOT NULL auto_increment,
  `category_name` varchar(255) NOT NULL default '',
  `category_parent` int(11) NOT NULL default '0',
  `category_order` int(3) default '0',
  `category_url` varchar(255) default '',
  `category_highlight` int(1) NOT NULL default '0',
  PRIMARY KEY  (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `category`
--


-- --------------------------------------------------------

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(100) NOT NULL,
  `shorttitle` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `cuit` varchar(100) default NULL,
  `phone` varchar(100) default NULL,
  `address` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `website` varchar(255) default NULL,
  `creation_date` datetime NOT NULL,
  `creation_userid` int(11) NOT NULL,
  `modification_date` datetime NOT NULL,
  `modification_userid` int(11) default NULL,
  `state` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `client`
--

INSERT INTO `client` VALUES(1, 'nuevo cliente', 'nuevo-cliente', '', NULL, NULL, NULL, NULL, NULL, '2014-07-01 20:00:35', 0, '0000-00-00 00:00:00', 11, 0);
INSERT INTO `client` VALUES(2, 'otro cliente más', 'otro-cliente-mas', '', '20-21654-12', '234234-234234', 'Avellaneda 302, Tigre, Buenos Aires, Argentina', 'ariel@frooit.com', 'www.frooit.com', '2014-07-01 20:06:58', 0, '0000-00-00 00:00:00', 11, 0);
INSERT INTO `client` VALUES(3, 'GoDaro', 'godaro', '', '30-32424234-0', '34234234.234234', 'Pepe 2342, San Fernando, Buenos Aires, Argentina', 'daro@godaro.com', 'www.godaro.com', '2014-07-01 20:13:33', 0, '0000-00-00 00:00:00', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL auto_increment,
  `objecttype_id` int(11) NOT NULL default '1',
  `object_id` int(11) NOT NULL default '0',
  `parent_id` int(11) NOT NULL default '0',
  `comment_content` text,
  `comment_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL default '0',
  `state_id` int(1) NOT NULL default '1',
  `user_report` int(11) NOT NULL default '0',
  `motive_report` varchar(255) default '',
  PRIMARY KEY  (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `comment`
--


-- --------------------------------------------------------

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL auto_increment,
  `location_name` varchar(255) NOT NULL default '',
  `location_parent` int(11) NOT NULL default '0',
  `location_order` int(3) default '0',
  PRIMARY KEY  (`location_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2445 ;

--
-- Dumping data for table `location`
--

INSERT INTO `location` VALUES(1, 'Argentina', 0, 1);
INSERT INTO `location` VALUES(121, 'Catamarca', 1, 8);
INSERT INTO `location` VALUES(120, 'Capital Federal/GBA', 1, 7);
INSERT INTO `location` VALUES(119, 'Bs.As. (fuera de GBA)', 1, 6);
INSERT INTO `location` VALUES(118, 'GBA Sur', 1, 5);
INSERT INTO `location` VALUES(117, 'GBA Oeste', 1, 4);
INSERT INTO `location` VALUES(226, 'San Fernando', 116, 0);
INSERT INTO `location` VALUES(114, 'Capital Federal', 1, 1);
INSERT INTO `location` VALUES(122, 'Chaco', 1, 9);
INSERT INTO `location` VALUES(116, 'GBA Norte', 1, 3);
INSERT INTO `location` VALUES(123, 'Chubut', 1, 10);
INSERT INTO `location` VALUES(124, 'Córdoba', 1, 11);
INSERT INTO `location` VALUES(125, 'Corrientes', 1, 12);
INSERT INTO `location` VALUES(126, 'Entre Ríos', 1, 13);
INSERT INTO `location` VALUES(127, 'Formosa', 1, 14);
INSERT INTO `location` VALUES(128, 'Jujuy', 1, 15);
INSERT INTO `location` VALUES(129, 'La Pampa', 1, 16);
INSERT INTO `location` VALUES(130, 'La Rioja', 1, 17);
INSERT INTO `location` VALUES(131, 'Mendoza', 1, 18);
INSERT INTO `location` VALUES(132, 'Misiones', 1, 19);
INSERT INTO `location` VALUES(133, 'Neuquén', 1, 20);
INSERT INTO `location` VALUES(134, 'Otra', 1, 21);
INSERT INTO `location` VALUES(135, 'Río Negro', 1, 22);
INSERT INTO `location` VALUES(136, 'Salta', 1, 23);
INSERT INTO `location` VALUES(137, 'San Juan', 1, 24);
INSERT INTO `location` VALUES(138, 'San Luis', 1, 25);
INSERT INTO `location` VALUES(139, 'Santa Cruz', 1, 26);
INSERT INTO `location` VALUES(140, 'Santa Fe', 1, 27);
INSERT INTO `location` VALUES(141, 'Santiago Del Estero', 1, 28);
INSERT INTO `location` VALUES(142, 'Tierra Del Fuego', 1, 29);
INSERT INTO `location` VALUES(143, 'Tucumán', 1, 30);
INSERT INTO `location` VALUES(144, 'Exterior', 1, 31);
INSERT INTO `location` VALUES(146, 'Agronomia', 114, 1);
INSERT INTO `location` VALUES(147, 'Almagro', 114, 1);
INSERT INTO `location` VALUES(148, 'Balvanera', 114, 1);
INSERT INTO `location` VALUES(149, 'Belgrano', 114, 1);
INSERT INTO `location` VALUES(150, 'Caballito', 114, 1);
INSERT INTO `location` VALUES(163, 'Barracas', 114, 1);
INSERT INTO `location` VALUES(152, 'Chacarita', 114, 1);
INSERT INTO `location` VALUES(153, 'Flores', 114, 1);
INSERT INTO `location` VALUES(162, 'Abasto', 114, 1);
INSERT INTO `location` VALUES(155, 'Monserrat', 114, 1);
INSERT INTO `location` VALUES(156, 'Nuñez', 114, 1);
INSERT INTO `location` VALUES(157, 'Palermo', 114, 1);
INSERT INTO `location` VALUES(158, 'Puerto Madero', 114, 1);
INSERT INTO `location` VALUES(159, 'Recoleta', 114, 1);
INSERT INTO `location` VALUES(160, 'Retiro', 114, 1);
INSERT INTO `location` VALUES(161, 'San Telmo', 114, 1);
INSERT INTO `location` VALUES(164, 'Barrio Norte', 114, 1);
INSERT INTO `location` VALUES(165, 'Boedo', 114, 1);
INSERT INTO `location` VALUES(166, 'Coghlan', 114, 1);
INSERT INTO `location` VALUES(167, 'Colegiales', 114, 1);
INSERT INTO `location` VALUES(168, 'Constitución', 114, 1);
INSERT INTO `location` VALUES(169, 'Floresta', 114, 1);
INSERT INTO `location` VALUES(170, 'La Boca', 114, 1);
INSERT INTO `location` VALUES(171, 'Liniers', 114, 1);
INSERT INTO `location` VALUES(172, 'Mataderos', 114, 1);
INSERT INTO `location` VALUES(173, 'Monte Castro', 114, 1);
INSERT INTO `location` VALUES(174, 'Nueva Pompeya', 114, 1);
INSERT INTO `location` VALUES(175, 'Once', 114, 1);
INSERT INTO `location` VALUES(176, 'Parque Avellaneda', 114, 1);
INSERT INTO `location` VALUES(177, 'Parque Chacabuco', 114, 1);
INSERT INTO `location` VALUES(178, 'Parque Patricios', 114, 1);
INSERT INTO `location` VALUES(179, 'Paternal', 114, 1);
INSERT INTO `location` VALUES(180, 'Saavedra', 114, 1);
INSERT INTO `location` VALUES(181, 'San Cristobal', 114, 1);
INSERT INTO `location` VALUES(182, 'San Nicolas', 114, 1);
INSERT INTO `location` VALUES(183, 'Velez Sarsfield', 114, 1);
INSERT INTO `location` VALUES(184, 'Versalles', 114, 1);
INSERT INTO `location` VALUES(185, 'Villa Crespo', 114, 1);
INSERT INTO `location` VALUES(186, 'Villa Devoto', 114, 1);
INSERT INTO `location` VALUES(187, 'Villa General Mitre', 114, 1);
INSERT INTO `location` VALUES(188, 'Villa Lugano', 114, 1);
INSERT INTO `location` VALUES(189, 'Villa Luro', 114, 1);
INSERT INTO `location` VALUES(190, 'Villa Ortuzar', 114, 1);
INSERT INTO `location` VALUES(191, 'Villa Pueyrredon', 114, 1);
INSERT INTO `location` VALUES(192, 'Villa Real', 114, 1);
INSERT INTO `location` VALUES(193, 'Villa Riachuelo', 114, 1);
INSERT INTO `location` VALUES(194, 'Villa Santa Rita', 114, 1);
INSERT INTO `location` VALUES(195, 'Villa Soldati', 114, 1);
INSERT INTO `location` VALUES(196, 'Villa Urquiza', 114, 1);
INSERT INTO `location` VALUES(197, 'Villa del Parque', 114, 1);
INSERT INTO `location` VALUES(198, 'Bahía Blanca', 119, 1);
INSERT INTO `location` VALUES(199, 'La Rioja Capital', 130, 1);
INSERT INTO `location` VALUES(200, 'Córdoba Capital', 124, 1);
INSERT INTO `location` VALUES(201, 'Mendoza Capital', 131, 1);
INSERT INTO `location` VALUES(202, 'San Miguel de Tucumán', 143, 1);
INSERT INTO `location` VALUES(203, 'Santa Fe Capital', 140, 1);
INSERT INTO `location` VALUES(204, 'Resistencia', 122, 1);
INSERT INTO `location` VALUES(205, 'Venado Tuerto', 140, 1);
INSERT INTO `location` VALUES(206, 'Salta capital', 136, 0);
INSERT INTO `location` VALUES(207, 'Morón', 117, 0);
INSERT INTO `location` VALUES(209, 'La Plata', 119, 0);
INSERT INTO `location` VALUES(210, 'Lanús', 118, 0);
INSERT INTO `location` VALUES(211, 'La Matanza', 117, 0);
INSERT INTO `location` VALUES(212, 'Quilmes', 118, 0);
INSERT INTO `location` VALUES(213, 'San Martín', 116, 0);
INSERT INTO `location` VALUES(214, 'Mar del Plata', 119, 0);
INSERT INTO `location` VALUES(215, 'Rosario', 140, 0);
INSERT INTO `location` VALUES(216, 'Vicente López, Olivos', 116, 0);
INSERT INTO `location` VALUES(217, 'San Isidro', 116, 0);
INSERT INTO `location` VALUES(225, 'San Isidro, Villa Adelina', 116, 0);
INSERT INTO `location` VALUES(221, 'Rafaela', 140, 0);
INSERT INTO `location` VALUES(222, 'Cañuelas', 119, 0);
INSERT INTO `location` VALUES(223, 'San Francisco ', 124, 0);
INSERT INTO `location` VALUES(224, 'Río Grande', 142, 0);
INSERT INTO `location` VALUES(227, 'Pinamar', 119, 0);
INSERT INTO `location` VALUES(228, 'Río Cuarto', 124, 0);
INSERT INTO `location` VALUES(229, 'Pilar', 116, 0);
INSERT INTO `location` VALUES(230, 'Villa Rosa', 119, 0);
INSERT INTO `location` VALUES(650, '25 de Mayo', 119, 0);
INSERT INTO `location` VALUES(651, '30 de Agosto', 119, 0);
INSERT INTO `location` VALUES(652, '9 de Julio', 119, 0);
INSERT INTO `location` VALUES(653, 'Acevedo', 119, 0);
INSERT INTO `location` VALUES(654, 'Adolfo Gonzales Chaves', 119, 0);
INSERT INTO `location` VALUES(655, 'Alberti', 119, 0);
INSERT INTO `location` VALUES(656, 'Alsina', 119, 0);
INSERT INTO `location` VALUES(657, 'Ameghino', 119, 0);
INSERT INTO `location` VALUES(658, 'Arenaza', 119, 0);
INSERT INTO `location` VALUES(659, 'Argentino Roca', 119, 0);
INSERT INTO `location` VALUES(660, 'Arrecifes', 119, 0);
INSERT INTO `location` VALUES(661, 'Arribeños', 119, 0);
INSERT INTO `location` VALUES(662, 'Arroyo Dulce', 119, 0);
INSERT INTO `location` VALUES(663, 'Ascensión', 119, 0);
INSERT INTO `location` VALUES(664, 'Ayacucho', 119, 0);
INSERT INTO `location` VALUES(665, 'Azul', 119, 0);
INSERT INTO `location` VALUES(666, 'Baigorrita', 119, 0);
INSERT INTO `location` VALUES(667, 'Balcarce', 119, 0);
INSERT INTO `location` VALUES(668, 'Banderaló', 119, 0);
INSERT INTO `location` VALUES(669, 'Baradero', 119, 0);
INSERT INTO `location` VALUES(670, 'Barker', 119, 0);
INSERT INTO `location` VALUES(671, 'Batán', 119, 0);
INSERT INTO `location` VALUES(672, 'Bayauca', 119, 0);
INSERT INTO `location` VALUES(673, 'Benito Juarez', 119, 0);
INSERT INTO `location` VALUES(674, 'Berisso', 119, 0);
INSERT INTO `location` VALUES(675, 'Beruti', 119, 0);
INSERT INTO `location` VALUES(676, 'Blaquier', 119, 0);
INSERT INTO `location` VALUES(677, 'Bragado', 119, 0);
INSERT INTO `location` VALUES(678, 'Cabildo', 119, 0);
INSERT INTO `location` VALUES(679, 'Cacharí', 119, 0);
INSERT INTO `location` VALUES(680, 'Cacique', 119, 0);
INSERT INTO `location` VALUES(681, 'Camet', 119, 0);
INSERT INTO `location` VALUES(682, 'Campana', 119, 0);
INSERT INTO `location` VALUES(683, 'Capadmalal', 119, 0);
INSERT INTO `location` VALUES(684, 'Capilla del Señor', 119, 0);
INSERT INTO `location` VALUES(685, 'Capitán Sarmiento', 119, 0);
INSERT INTO `location` VALUES(686, 'Carabelas', 119, 0);
INSERT INTO `location` VALUES(687, 'Carhué', 119, 0);
INSERT INTO `location` VALUES(688, 'Cariló', 119, 0);
INSERT INTO `location` VALUES(689, 'Carlos Casares', 119, 0);
INSERT INTO `location` VALUES(690, 'Carlos María Naon', 119, 0);
INSERT INTO `location` VALUES(691, 'Carlos Tejedor', 119, 0);
INSERT INTO `location` VALUES(692, 'Carmen de Areco', 119, 0);
INSERT INTO `location` VALUES(693, 'Carmen de Patagones', 119, 0);
INSERT INTO `location` VALUES(694, 'Casbas', 119, 0);
INSERT INTO `location` VALUES(695, 'Castelli', 119, 0);
INSERT INTO `location` VALUES(696, 'Castilla', 119, 0);
INSERT INTO `location` VALUES(697, 'Chacabuco', 119, 0);
INSERT INTO `location` VALUES(698, 'Chascomús', 119, 0);
INSERT INTO `location` VALUES(699, 'Chillar', 119, 0);
INSERT INTO `location` VALUES(700, 'Chivilcoy', 119, 0);
INSERT INTO `location` VALUES(701, 'Claraz', 119, 0);
INSERT INTO `location` VALUES(702, 'Claromecó', 119, 0);
INSERT INTO `location` VALUES(703, 'Colón', 119, 0);
INSERT INTO `location` VALUES(704, 'Colonia Arcángel', 119, 0);
INSERT INTO `location` VALUES(705, 'Colonia Hinojo', 119, 0);
INSERT INTO `location` VALUES(706, 'Colonia San Miguel', 119, 0);
INSERT INTO `location` VALUES(707, 'Colonia Seré', 119, 0);
INSERT INTO `location` VALUES(708, 'Comandante Otamendi', 119, 0);
INSERT INTO `location` VALUES(709, 'Comodoro Py', 119, 0);
INSERT INTO `location` VALUES(710, 'Conesa', 119, 0);
INSERT INTO `location` VALUES(711, 'Copetonas', 119, 0);
INSERT INTO `location` VALUES(712, 'Coronel Brandsen', 119, 0);
INSERT INTO `location` VALUES(713, 'Coronel Dorrego', 119, 0);
INSERT INTO `location` VALUES(714, 'Coronel Granada', 119, 0);
INSERT INTO `location` VALUES(715, 'Coronel Martinez de Hoz', 119, 0);
INSERT INTO `location` VALUES(716, 'Coronel Pringles', 119, 0);
INSERT INTO `location` VALUES(717, 'Coronel Suárez', 119, 0);
INSERT INTO `location` VALUES(718, 'Coronel Vidal', 119, 0);
INSERT INTO `location` VALUES(719, 'Daireaux', 119, 0);
INSERT INTO `location` VALUES(720, 'Darragueira', 119, 0);
INSERT INTO `location` VALUES(721, 'De La Garma', 119, 0);
INSERT INTO `location` VALUES(722, 'Del Carril', 119, 0);
INSERT INTO `location` VALUES(723, 'Del Valle', 119, 0);
INSERT INTO `location` VALUES(724, 'Dolores', 119, 0);
INSERT INTO `location` VALUES(725, 'Dudignac', 119, 0);
INSERT INTO `location` VALUES(726, 'Duggan', 119, 0);
INSERT INTO `location` VALUES(727, 'El Socorro', 119, 0);
INSERT INTO `location` VALUES(728, 'Emilio V. Bunge', 119, 0);
INSERT INTO `location` VALUES(729, 'Ensenada', 119, 0);
INSERT INTO `location` VALUES(730, 'Espartillar', 119, 0);
INSERT INTO `location` VALUES(731, 'Exaltación De La Cruz', 119, 0);
INSERT INTO `location` VALUES(732, 'Ferré', 119, 0);
INSERT INTO `location` VALUES(733, 'Fortín Olavarria', 119, 0);
INSERT INTO `location` VALUES(734, 'Gahan', 119, 0);
INSERT INTO `location` VALUES(735, 'Garmania', 119, 0);
INSERT INTO `location` VALUES(736, 'Garré', 119, 0);
INSERT INTO `location` VALUES(737, 'General Alvear', 119, 0);
INSERT INTO `location` VALUES(738, 'General Arenales', 119, 0);
INSERT INTO `location` VALUES(739, 'General Belgrano', 119, 0);
INSERT INTO `location` VALUES(740, 'General Conesa', 119, 0);
INSERT INTO `location` VALUES(741, 'General Daniel Cerri', 119, 0);
INSERT INTO `location` VALUES(742, 'General Gelly', 119, 0);
INSERT INTO `location` VALUES(743, 'General Guido', 119, 0);
INSERT INTO `location` VALUES(744, 'General Juan Madariaga', 119, 0);
INSERT INTO `location` VALUES(745, 'General Lamadrid', 119, 0);
INSERT INTO `location` VALUES(746, 'General Las Heras', 119, 0);
INSERT INTO `location` VALUES(747, 'General Lavalle', 119, 0);
INSERT INTO `location` VALUES(748, 'General Mansilla', 119, 0);
INSERT INTO `location` VALUES(749, 'General O`Brien', 119, 0);
INSERT INTO `location` VALUES(750, 'General Pinto', 119, 0);
INSERT INTO `location` VALUES(751, 'General Pirán', 119, 0);
INSERT INTO `location` VALUES(752, 'General Rojo', 119, 0);
INSERT INTO `location` VALUES(753, 'General Viamonte', 119, 0);
INSERT INTO `location` VALUES(754, 'General Villegas', 119, 0);
INSERT INTO `location` VALUES(755, 'Gobernador Ugarte', 119, 0);
INSERT INTO `location` VALUES(756, 'González Moreno', 119, 0);
INSERT INTO `location` VALUES(757, 'Goyena', 119, 0);
INSERT INTO `location` VALUES(758, 'Gral. Las Heras', 119, 0);
INSERT INTO `location` VALUES(759, 'Guamirí', 119, 0);
INSERT INTO `location` VALUES(760, 'Guerrico', 119, 0);
INSERT INTO `location` VALUES(761, 'Guisasola', 119, 0);
INSERT INTO `location` VALUES(762, 'Henderson', 119, 0);
INSERT INTO `location` VALUES(763, 'Hilario Ascasubi', 119, 0);
INSERT INTO `location` VALUES(764, 'Hinojo', 119, 0);
INSERT INTO `location` VALUES(765, 'Huanguelén', 119, 0);
INSERT INTO `location` VALUES(766, 'Indio Rico', 119, 0);
INSERT INTO `location` VALUES(767, 'Inés Indart', 119, 0);
INSERT INTO `location` VALUES(768, 'Jáuregui', 119, 0);
INSERT INTO `location` VALUES(769, 'Jeppener', 119, 0);
INSERT INTO `location` VALUES(770, 'Juan Bautista Alberdi', 119, 0);
INSERT INTO `location` VALUES(771, 'Juan José Paso', 119, 0);
INSERT INTO `location` VALUES(772, 'Juan N. Fernandez', 119, 0);
INSERT INTO `location` VALUES(773, 'Junín', 119, 0);
INSERT INTO `location` VALUES(774, 'La Emilia', 119, 0);
INSERT INTO `location` VALUES(775, 'La Lucila del Mar', 119, 0);
INSERT INTO `location` VALUES(776, 'La Niña', 119, 0);
INSERT INTO `location` VALUES(777, 'Laguna Alsina', 119, 0);
INSERT INTO `location` VALUES(778, 'Laprida', 119, 0);
INSERT INTO `location` VALUES(779, 'Las Flores', 119, 0);
INSERT INTO `location` VALUES(780, 'Las Marianas', 119, 0);
INSERT INTO `location` VALUES(781, 'Las Toninas', 119, 0);
INSERT INTO `location` VALUES(782, 'Leandro N. Alem', 119, 0);
INSERT INTO `location` VALUES(783, 'Lima', 119, 0);
INSERT INTO `location` VALUES(784, 'Lincoln ', 119, 0);
INSERT INTO `location` VALUES(785, 'Lobería', 119, 0);
INSERT INTO `location` VALUES(786, 'Lobos', 119, 0);
INSERT INTO `location` VALUES(787, 'Los Cardales', 119, 0);
INSERT INTO `location` VALUES(788, 'Luján', 119, 0);
INSERT INTO `location` VALUES(789, 'Magdalena', 119, 0);
INSERT INTO `location` VALUES(790, 'Maipú', 119, 0);
INSERT INTO `location` VALUES(791, 'Manuel J. Cobo', 119, 0);
INSERT INTO `location` VALUES(792, 'Mar De Ajó', 119, 0);
INSERT INTO `location` VALUES(793, 'Mar Del Sur', 119, 0);
INSERT INTO `location` VALUES(794, 'Mar Del Tuyú', 119, 0);
INSERT INTO `location` VALUES(795, 'María Ignacia', 119, 0);
INSERT INTO `location` VALUES(796, 'Mariano H. Alfonzo', 119, 0);
INSERT INTO `location` VALUES(797, 'Máximo Paz', 119, 0);
INSERT INTO `location` VALUES(798, 'Mayor Buratovich', 119, 0);
INSERT INTO `location` VALUES(799, 'Maza', 119, 0);
INSERT INTO `location` VALUES(800, 'Mechita', 119, 0);
INSERT INTO `location` VALUES(801, 'Mechongué', 119, 0);
INSERT INTO `location` VALUES(802, 'Médanos', 119, 0);
INSERT INTO `location` VALUES(803, 'Mercedes', 119, 0);
INSERT INTO `location` VALUES(804, 'Micaela Cascallares', 119, 0);
INSERT INTO `location` VALUES(805, 'Miramar', 119, 0);
INSERT INTO `location` VALUES(806, 'Moll', 119, 0);
INSERT INTO `location` VALUES(807, 'Monez Cazón', 119, 0);
INSERT INTO `location` VALUES(808, 'Moquehuá', 119, 0);
INSERT INTO `location` VALUES(809, 'Morse', 119, 0);
INSERT INTO `location` VALUES(810, 'N. Olivera', 119, 0);
INSERT INTO `location` VALUES(811, 'Navarro', 119, 0);
INSERT INTO `location` VALUES(812, 'Necochea', 119, 0);
INSERT INTO `location` VALUES(813, 'Norberto de la Riestra', 119, 0);
INSERT INTO `location` VALUES(814, 'OHiggins', 119, 0);
INSERT INTO `location` VALUES(815, 'Olavarría', 119, 0);
INSERT INTO `location` VALUES(816, 'Olivera', 119, 0);
INSERT INTO `location` VALUES(817, 'Open Door', 119, 0);
INSERT INTO `location` VALUES(818, 'Orense', 119, 0);
INSERT INTO `location` VALUES(819, 'Oriente', 119, 0);
INSERT INTO `location` VALUES(820, 'Ostende', 119, 0);
INSERT INTO `location` VALUES(821, 'Pasteur', 119, 0);
INSERT INTO `location` VALUES(822, 'Patricios', 119, 0);
INSERT INTO `location` VALUES(823, 'Pedernales', 119, 0);
INSERT INTO `location` VALUES(824, 'Pedro Luro', 119, 0);
INSERT INTO `location` VALUES(825, 'Pehuajó', 119, 0);
INSERT INTO `location` VALUES(826, 'Pellegrini', 119, 0);
INSERT INTO `location` VALUES(827, 'Pérez Millán', 119, 0);
INSERT INTO `location` VALUES(828, 'Pergamino', 119, 0);
INSERT INTO `location` VALUES(829, 'Pila', 119, 0);
INSERT INTO `location` VALUES(830, 'Pirovano', 119, 0);
INSERT INTO `location` VALUES(831, 'Puán', 119, 0);
INSERT INTO `location` VALUES(832, 'Pueblo San José', 119, 0);
INSERT INTO `location` VALUES(833, 'Pueblo Santa María', 119, 0);
INSERT INTO `location` VALUES(834, 'Pueblo Santa Trinidad', 119, 0);
INSERT INTO `location` VALUES(835, 'Punta Alta', 119, 0);
INSERT INTO `location` VALUES(836, 'Punta Lara', 119, 0);
INSERT INTO `location` VALUES(837, 'Quenumá', 119, 0);
INSERT INTO `location` VALUES(838, 'Quequén', 119, 0);
INSERT INTO `location` VALUES(839, 'Quiroga', 119, 0);
INSERT INTO `location` VALUES(840, 'Rafael Obligado', 119, 0);
INSERT INTO `location` VALUES(841, 'Ramallo', 119, 0);
INSERT INTO `location` VALUES(842, 'Ramón Santamarina', 119, 0);
INSERT INTO `location` VALUES(843, 'Rancagua', 119, 0);
INSERT INTO `location` VALUES(844, 'Ranchos', 119, 0);
INSERT INTO `location` VALUES(845, 'Rauch', 119, 0);
INSERT INTO `location` VALUES(846, 'Rawson', 119, 0);
INSERT INTO `location` VALUES(847, 'Río Tala', 119, 0);
INSERT INTO `location` VALUES(848, 'Rivadavia', 119, 0);
INSERT INTO `location` VALUES(849, 'Rivera', 119, 0);
INSERT INTO `location` VALUES(850, 'Roberts', 119, 0);
INSERT INTO `location` VALUES(851, 'Rojas', 119, 0);
INSERT INTO `location` VALUES(852, 'Roque Pérez', 119, 0);
INSERT INTO `location` VALUES(853, 'Saavedra', 119, 0);
INSERT INTO `location` VALUES(854, 'Saladillo', 119, 0);
INSERT INTO `location` VALUES(855, 'Salazar', 119, 0);
INSERT INTO `location` VALUES(856, 'Saldungaray', 119, 0);
INSERT INTO `location` VALUES(857, 'Salliqueló', 119, 0);
INSERT INTO `location` VALUES(858, 'Salto', 119, 0);
INSERT INTO `location` VALUES(859, 'Salvador María', 119, 0);
INSERT INTO `location` VALUES(860, 'San Agustín', 119, 0);
INSERT INTO `location` VALUES(861, 'San Andrés de Giles', 119, 0);
INSERT INTO `location` VALUES(862, 'San Antonio De Areco', 119, 0);
INSERT INTO `location` VALUES(863, 'San Bernardo Del Tuyú', 119, 0);
INSERT INTO `location` VALUES(864, 'San Carlos de Bolivar', 119, 0);
INSERT INTO `location` VALUES(865, 'San Cayetano', 119, 0);
INSERT INTO `location` VALUES(866, 'San Clemente Del Tuyú', 119, 0);
INSERT INTO `location` VALUES(867, 'San Francisco de Bellocq', 119, 0);
INSERT INTO `location` VALUES(868, 'San Manuel', 119, 0);
INSERT INTO `location` VALUES(869, 'San Miguel del Monte', 119, 0);
INSERT INTO `location` VALUES(870, 'San Nicolás de los Arroyos', 119, 0);
INSERT INTO `location` VALUES(871, 'San Pedro', 119, 0);
INSERT INTO `location` VALUES(872, 'San Vicente', 119, 0);
INSERT INTO `location` VALUES(873, 'Santa Clara del Mar', 119, 0);
INSERT INTO `location` VALUES(874, 'Santa Lucía', 119, 0);
INSERT INTO `location` VALUES(875, 'Santa Regina', 119, 0);
INSERT INTO `location` VALUES(876, 'Santa Teresita', 119, 0);
INSERT INTO `location` VALUES(877, 'Sas. Bayas', 119, 0);
INSERT INTO `location` VALUES(878, 'Sierra Chica', 119, 0);
INSERT INTO `location` VALUES(879, 'Sierra de la Ventana', 119, 0);
INSERT INTO `location` VALUES(880, 'Solés', 119, 0);
INSERT INTO `location` VALUES(881, 'Stroeder', 119, 0);
INSERT INTO `location` VALUES(882, 'Suipacha', 119, 0);
INSERT INTO `location` VALUES(883, 'Tandil', 119, 0);
INSERT INTO `location` VALUES(884, 'Tapalqué', 119, 0);
INSERT INTO `location` VALUES(885, 'Timonte', 119, 0);
INSERT INTO `location` VALUES(886, 'Todd', 119, 0);
INSERT INTO `location` VALUES(887, 'Tornquist', 119, 0);
INSERT INTO `location` VALUES(888, 'Torres', 119, 0);
INSERT INTO `location` VALUES(889, 'Trenque Lauquen', 119, 0);
INSERT INTO `location` VALUES(890, 'Tres Arroyos', 119, 0);
INSERT INTO `location` VALUES(891, 'Tres Lomas', 119, 0);
INSERT INTO `location` VALUES(892, 'Urdampilleta', 119, 0);
INSERT INTO `location` VALUES(893, 'Uribelarrea', 119, 0);
INSERT INTO `location` VALUES(894, 'Urquiza', 119, 0);
INSERT INTO `location` VALUES(895, 'Valeria del Mar', 119, 0);
INSERT INTO `location` VALUES(896, 'Vedia', 119, 0);
INSERT INTO `location` VALUES(897, 'Verónica', 119, 0);
INSERT INTO `location` VALUES(898, 'Vicente Casares', 119, 0);
INSERT INTO `location` VALUES(899, 'Villa Arcadia', 119, 0);
INSERT INTO `location` VALUES(900, 'Villa Estación Ramallo', 119, 0);
INSERT INTO `location` VALUES(901, 'Villa Fortabat', 119, 0);
INSERT INTO `location` VALUES(902, 'Villa Gesell', 119, 0);
INSERT INTO `location` VALUES(903, 'Villa Iris', 119, 0);
INSERT INTO `location` VALUES(904, 'Villa Lía', 119, 0);
INSERT INTO `location` VALUES(905, 'Villa Mónica', 119, 0);
INSERT INTO `location` VALUES(906, 'Villa Ortiz', 119, 0);
INSERT INTO `location` VALUES(907, 'Villa Sauze', 119, 0);
INSERT INTO `location` VALUES(908, 'Villalonga', 119, 0);
INSERT INTO `location` VALUES(909, 'Villanueva', 119, 0);
INSERT INTO `location` VALUES(910, 'Vivoretá', 119, 0);
INSERT INTO `location` VALUES(911, 'Zárate', 119, 0);
INSERT INTO `location` VALUES(912, 'Alijilán', 121, 0);
INSERT INTO `location` VALUES(913, 'Ambato', 121, 0);
INSERT INTO `location` VALUES(914, 'Ancasti', 121, 0);
INSERT INTO `location` VALUES(915, 'Andalgala', 121, 0);
INSERT INTO `location` VALUES(916, 'Antofagasta', 121, 0);
INSERT INTO `location` VALUES(917, 'Bañado de Ovanta', 121, 0);
INSERT INTO `location` VALUES(918, 'Belen', 121, 0);
INSERT INTO `location` VALUES(919, 'Capayan', 121, 0);
INSERT INTO `location` VALUES(920, 'Catamarca', 121, 0);
INSERT INTO `location` VALUES(921, 'Chañar Punco', 121, 0);
INSERT INTO `location` VALUES(922, 'Chumbicha', 121, 0);
INSERT INTO `location` VALUES(923, 'Colonia Nueva Coneta', 121, 0);
INSERT INTO `location` VALUES(924, 'Colpes', 121, 0);
INSERT INTO `location` VALUES(925, 'Coneta', 121, 0);
INSERT INTO `location` VALUES(926, 'Copacabana', 121, 0);
INSERT INTO `location` VALUES(927, 'Corral Quemado', 121, 0);
INSERT INTO `location` VALUES(928, 'El Alto', 121, 0);
INSERT INTO `location` VALUES(929, 'El Rodeo', 121, 0);
INSERT INTO `location` VALUES(930, 'Esquiú', 121, 0);
INSERT INTO `location` VALUES(931, 'F.M.Esquiu', 121, 0);
INSERT INTO `location` VALUES(932, 'Famatanca', 121, 0);
INSERT INTO `location` VALUES(933, 'Farallón Negro', 121, 0);
INSERT INTO `location` VALUES(934, 'Fiambalá', 121, 0);
INSERT INTO `location` VALUES(935, 'Hualfín', 121, 0);
INSERT INTO `location` VALUES(936, 'Huillampina', 121, 0);
INSERT INTO `location` VALUES(937, 'Icaño', 121, 0);
INSERT INTO `location` VALUES(938, 'La Guardia', 121, 0);
INSERT INTO `location` VALUES(939, 'La Merced', 121, 0);
INSERT INTO `location` VALUES(940, 'La Paz', 121, 0);
INSERT INTO `location` VALUES(941, 'La Puerta', 121, 0);
INSERT INTO `location` VALUES(942, 'Londres', 121, 0);
INSERT INTO `location` VALUES(943, 'Loro Huasi', 121, 0);
INSERT INTO `location` VALUES(944, 'Los Altos', 121, 0);
INSERT INTO `location` VALUES(945, 'Medanitos', 121, 0);
INSERT INTO `location` VALUES(946, 'Miraflores', 121, 0);
INSERT INTO `location` VALUES(947, 'Mutquin', 121, 0);
INSERT INTO `location` VALUES(948, 'Paclin', 121, 0);
INSERT INTO `location` VALUES(949, 'Palo Blanco', 121, 0);
INSERT INTO `location` VALUES(950, 'Poman', 121, 0);
INSERT INTO `location` VALUES(951, 'Quirós', 121, 0);
INSERT INTO `location` VALUES(952, 'Recreo', 121, 0);
INSERT INTO `location` VALUES(953, 'Rincón', 121, 0);
INSERT INTO `location` VALUES(954, 'San Fernando del V. de Catamarca', 121, 0);
INSERT INTO `location` VALUES(955, 'San Isidro', 121, 0);
INSERT INTO `location` VALUES(956, 'San José', 121, 0);
INSERT INTO `location` VALUES(957, 'Santa Maria', 121, 0);
INSERT INTO `location` VALUES(958, 'Santa Rosa', 121, 0);
INSERT INTO `location` VALUES(959, 'Saujil', 121, 0);
INSERT INTO `location` VALUES(960, 'Siján', 121, 0);
INSERT INTO `location` VALUES(961, 'Tinogasta', 121, 0);
INSERT INTO `location` VALUES(962, 'Valle Viejo', 121, 0);
INSERT INTO `location` VALUES(963, 'Villa Dolores', 121, 0);
INSERT INTO `location` VALUES(964, 'Villa El Alto', 121, 0);
INSERT INTO `location` VALUES(965, '1 de Mayo', 122, 0);
INSERT INTO `location` VALUES(966, '12 de Octubre', 122, 0);
INSERT INTO `location` VALUES(967, '25 de Mayo', 122, 0);
INSERT INTO `location` VALUES(968, '9 de Julio', 122, 0);
INSERT INTO `location` VALUES(969, 'Almirante Brown', 122, 0);
INSERT INTO `location` VALUES(970, 'Avia Terai', 122, 0);
INSERT INTO `location` VALUES(971, 'Barranqueras', 122, 0);
INSERT INTO `location` VALUES(972, 'Basail', 122, 0);
INSERT INTO `location` VALUES(973, 'Bermejo', 122, 0);
INSERT INTO `location` VALUES(974, 'Campo Largo', 122, 0);
INSERT INTO `location` VALUES(975, 'Capitán Solari', 122, 0);
INSERT INTO `location` VALUES(976, 'Chacabuco', 122, 0);
INSERT INTO `location` VALUES(977, 'Charadai', 122, 0);
INSERT INTO `location` VALUES(978, 'Charata', 122, 0);
INSERT INTO `location` VALUES(979, 'Ciervo Petiso', 122, 0);
INSERT INTO `location` VALUES(980, 'Colonia Aborígen Chaco', 122, 0);
INSERT INTO `location` VALUES(981, 'Colonia Benítez', 122, 0);
INSERT INTO `location` VALUES(982, 'Colonia Elisa', 122, 0);
INSERT INTO `location` VALUES(983, 'Colonia Unidas. C. del Bermejo', 122, 0);
INSERT INTO `location` VALUES(984, 'Comandante Fernandez', 122, 0);
INSERT INTO `location` VALUES(985, 'Coronel Du Graty', 122, 0);
INSERT INTO `location` VALUES(986, 'Corzuela', 122, 0);
INSERT INTO `location` VALUES(987, 'Cote Lai', 122, 0);
INSERT INTO `location` VALUES(988, 'El Sauzalito', 122, 0);
INSERT INTO `location` VALUES(989, 'F.Sta Maria de Oro', 122, 0);
INSERT INTO `location` VALUES(990, 'Fontana', 122, 0);
INSERT INTO `location` VALUES(991, 'Gancedo', 122, 0);
INSERT INTO `location` VALUES(992, 'General Belgrano', 122, 0);
INSERT INTO `location` VALUES(993, 'General Donovan', 122, 0);
INSERT INTO `location` VALUES(994, 'General Guemes', 122, 0);
INSERT INTO `location` VALUES(995, 'Gral. José de San Martín', 122, 0);
INSERT INTO `location` VALUES(996, 'Gral. Pinedo', 122, 0);
INSERT INTO `location` VALUES(997, 'Gral. Vedia', 122, 0);
INSERT INTO `location` VALUES(998, 'Hermoso Campo', 122, 0);
INSERT INTO `location` VALUES(999, 'Independencia', 122, 0);
INSERT INTO `location` VALUES(1000, 'Juan José Castelli', 122, 0);
INSERT INTO `location` VALUES(1001, 'La Clotilde', 122, 0);
INSERT INTO `location` VALUES(1002, 'La Escondida', 122, 0);
INSERT INTO `location` VALUES(1003, 'La Leonesa', 122, 0);
INSERT INTO `location` VALUES(1004, 'La Tigra', 122, 0);
INSERT INTO `location` VALUES(1005, 'La Verde', 122, 0);
INSERT INTO `location` VALUES(1006, 'Laguna Limpia', 122, 0);
INSERT INTO `location` VALUES(1007, 'Lapachito', 122, 0);
INSERT INTO `location` VALUES(1008, 'Las Breñas', 122, 0);
INSERT INTO `location` VALUES(1009, 'Las Garcitas', 122, 0);
INSERT INTO `location` VALUES(1010, 'Ldor Gral San Martin', 122, 0);
INSERT INTO `location` VALUES(1011, 'Libertad', 122, 0);
INSERT INTO `location` VALUES(1012, 'Los Frentones', 122, 0);
INSERT INTO `location` VALUES(1013, 'Machagai', 122, 0);
INSERT INTO `location` VALUES(1014, 'Maipu', 122, 0);
INSERT INTO `location` VALUES(1015, 'Makellé', 122, 0);
INSERT INTO `location` VALUES(1016, 'Margarita Belén', 122, 0);
INSERT INTO `location` VALUES(1017, 'Mayor Luis Fontana', 122, 0);
INSERT INTO `location` VALUES(1018, 'Napenay', 122, 0);
INSERT INTO `location` VALUES(1019, 'Nueva Pompeya', 122, 0);
INSERT INTO `location` VALUES(1020, 'O Higgins', 122, 0);
INSERT INTO `location` VALUES(1021, 'Pampa Almirón', 122, 0);
INSERT INTO `location` VALUES(1022, 'Pampa del Indio', 122, 0);
INSERT INTO `location` VALUES(1023, 'Pampa del Infierno', 122, 0);
INSERT INTO `location` VALUES(1024, 'Pres. de la Plaza', 122, 0);
INSERT INTO `location` VALUES(1025, 'Presidencia R. Sáenz Peña', 122, 0);
INSERT INTO `location` VALUES(1026, 'Presidencia Roca', 122, 0);
INSERT INTO `location` VALUES(1027, 'Pt. Bermejo', 122, 0);
INSERT INTO `location` VALUES(1028, 'Pt. Tirol', 122, 0);
INSERT INTO `location` VALUES(1029, 'Quitilipi', 122, 0);
INSERT INTO `location` VALUES(1030, 'Samuhú', 122, 0);
INSERT INTO `location` VALUES(1031, 'San Bernardo', 122, 0);
INSERT INTO `location` VALUES(1032, 'San Fernando', 122, 0);
INSERT INTO `location` VALUES(1033, 'San Lorenzo', 122, 0);
INSERT INTO `location` VALUES(1034, 'Santa Sylvina', 122, 0);
INSERT INTO `location` VALUES(1035, 'Sargento Cabral', 122, 0);
INSERT INTO `location` VALUES(1036, 'Selvas del Río del Oro', 122, 0);
INSERT INTO `location` VALUES(1037, 'Taco Pozo', 122, 0);
INSERT INTO `location` VALUES(1038, 'Tapenaga', 122, 0);
INSERT INTO `location` VALUES(1039, 'Tres Isletas', 122, 0);
INSERT INTO `location` VALUES(1040, 'Villa Ángela', 122, 0);
INSERT INTO `location` VALUES(1041, 'Villa Berthet', 122, 0);
INSERT INTO `location` VALUES(1042, 'Villa Río Bermejito', 122, 0);
INSERT INTO `location` VALUES(1043, 'Alto Río Senguer', 123, 0);
INSERT INTO `location` VALUES(1044, 'Camarones', 123, 0);
INSERT INTO `location` VALUES(1045, 'Cholila', 123, 0);
INSERT INTO `location` VALUES(1046, 'Ciudadela', 123, 0);
INSERT INTO `location` VALUES(1047, 'Comodoro Rivadavia', 123, 0);
INSERT INTO `location` VALUES(1048, 'Corcovado', 123, 0);
INSERT INTO `location` VALUES(1049, 'Cushamen', 123, 0);
INSERT INTO `location` VALUES(1050, 'Diadema Argentina', 123, 0);
INSERT INTO `location` VALUES(1051, 'Dolavon', 123, 0);
INSERT INTO `location` VALUES(1052, 'Don Bosco', 123, 0);
INSERT INTO `location` VALUES(1053, 'El Maitén', 123, 0);
INSERT INTO `location` VALUES(1054, 'Escalante', 123, 0);
INSERT INTO `location` VALUES(1055, 'Esquel', 123, 0);
INSERT INTO `location` VALUES(1056, 'Florentino Ameghino', 123, 0);
INSERT INTO `location` VALUES(1057, 'Futaleufu', 123, 0);
INSERT INTO `location` VALUES(1058, 'Gaiman', 123, 0);
INSERT INTO `location` VALUES(1059, 'Gastre', 123, 0);
INSERT INTO `location` VALUES(1060, 'General Mosconi', 123, 0);
INSERT INTO `location` VALUES(1061, 'Gobernador Costa', 123, 0);
INSERT INTO `location` VALUES(1062, 'Gualjaina', 123, 0);
INSERT INTO `location` VALUES(1063, 'Hoyo de Epuyén', 123, 0);
INSERT INTO `location` VALUES(1064, 'José de San Martín', 123, 0);
INSERT INTO `location` VALUES(1065, 'Lago Puelo', 123, 0);
INSERT INTO `location` VALUES(1066, 'Languiñeo', 123, 0);
INSERT INTO `location` VALUES(1067, 'Las Plumas', 123, 0);
INSERT INTO `location` VALUES(1068, 'Leleque', 123, 0);
INSERT INTO `location` VALUES(1069, 'Martires', 123, 0);
INSERT INTO `location` VALUES(1070, 'Paso de Indios', 123, 0);
INSERT INTO `location` VALUES(1071, 'Playa Unión', 123, 0);
INSERT INTO `location` VALUES(1072, 'Puerto Madryn', 123, 0);
INSERT INTO `location` VALUES(1073, 'Rada Tilly', 123, 0);
INSERT INTO `location` VALUES(1074, 'Rawson', 123, 0);
INSERT INTO `location` VALUES(1075, 'Río Mayo', 123, 0);
INSERT INTO `location` VALUES(1076, 'Río Pico', 123, 0);
INSERT INTO `location` VALUES(1077, 'Rio Senguer', 123, 0);
INSERT INTO `location` VALUES(1078, 'Sarmiento', 123, 0);
INSERT INTO `location` VALUES(1079, 'Tecka', 123, 0);
INSERT INTO `location` VALUES(1080, 'Tehuelches', 123, 0);
INSERT INTO `location` VALUES(1081, 'Telsen', 123, 0);
INSERT INTO `location` VALUES(1082, 'Trelew', 123, 0);
INSERT INTO `location` VALUES(1083, 'Trevellin', 123, 0);
INSERT INTO `location` VALUES(1084, 'Adelia María', 124, 0);
INSERT INTO `location` VALUES(1085, 'Alcira', 124, 0);
INSERT INTO `location` VALUES(1086, 'Alejandro Roca', 124, 0);
INSERT INTO `location` VALUES(1087, 'Alejo Ledesma', 124, 0);
INSERT INTO `location` VALUES(1088, 'Alicia', 124, 0);
INSERT INTO `location` VALUES(1089, 'Almafuerte', 124, 0);
INSERT INTO `location` VALUES(1090, 'Alta Gracia', 124, 0);
INSERT INTO `location` VALUES(1091, 'Alto Alegre', 124, 0);
INSERT INTO `location` VALUES(1092, 'Altos de Chipión', 124, 0);
INSERT INTO `location` VALUES(1093, 'Arias', 124, 0);
INSERT INTO `location` VALUES(1094, 'Arroyito', 124, 0);
INSERT INTO `location` VALUES(1095, 'Arroyo Cabral', 124, 0);
INSERT INTO `location` VALUES(1096, 'Ausonia', 124, 0);
INSERT INTO `location` VALUES(1097, 'Ballesteros', 124, 0);
INSERT INTO `location` VALUES(1098, 'Balnearia', 124, 0);
INSERT INTO `location` VALUES(1099, 'Benjamín Gould', 124, 0);
INSERT INTO `location` VALUES(1100, 'Berrotarán', 124, 0);
INSERT INTO `location` VALUES(1101, 'Bialet Massé', 124, 0);
INSERT INTO `location` VALUES(1102, 'Brinkmann', 124, 0);
INSERT INTO `location` VALUES(1103, 'Bulnes', 124, 0);
INSERT INTO `location` VALUES(1104, 'Calamuchita', 124, 0);
INSERT INTO `location` VALUES(1105, 'Calchín', 124, 0);
INSERT INTO `location` VALUES(1106, 'Camilo Aldao', 124, 0);
INSERT INTO `location` VALUES(1107, 'Cañada de Luque', 124, 0);
INSERT INTO `location` VALUES(1108, 'Canals', 124, 0);
INSERT INTO `location` VALUES(1109, 'Capilla del Monte', 124, 0);
INSERT INTO `location` VALUES(1110, 'Carnerillo', 124, 0);
INSERT INTO `location` VALUES(1111, 'Carrilobo', 124, 0);
INSERT INTO `location` VALUES(1112, 'Cavanagh', 124, 0);
INSERT INTO `location` VALUES(1113, 'Charras', 124, 0);
INSERT INTO `location` VALUES(1114, 'Chazón', 124, 0);
INSERT INTO `location` VALUES(1115, 'Cintra', 124, 0);
INSERT INTO `location` VALUES(1116, 'Colazo', 124, 0);
INSERT INTO `location` VALUES(1117, 'Colon', 124, 0);
INSERT INTO `location` VALUES(1118, 'Colonia Caroya', 124, 0);
INSERT INTO `location` VALUES(1119, 'Colonia Marina', 124, 0);
INSERT INTO `location` VALUES(1120, 'Colonia San Bartolomé', 124, 0);
INSERT INTO `location` VALUES(1121, 'Colonia Vignaud', 124, 0);
INSERT INTO `location` VALUES(1122, 'Coronel Baigorria', 124, 0);
INSERT INTO `location` VALUES(1123, 'Coronel Moldes', 124, 0);
INSERT INTO `location` VALUES(1124, 'Corral de Bustos', 124, 0);
INSERT INTO `location` VALUES(1125, 'Corralito', 124, 0);
INSERT INTO `location` VALUES(1126, 'Cosquín', 124, 0);
INSERT INTO `location` VALUES(1127, 'Costa Sacate', 124, 0);
INSERT INTO `location` VALUES(1128, 'Cruz Del Eje', 124, 0);
INSERT INTO `location` VALUES(1129, 'Dalmacio Vélez Sarsfield', 124, 0);
INSERT INTO `location` VALUES(1130, 'Deán Funes', 124, 0);
INSERT INTO `location` VALUES(1131, 'Del Campillo', 124, 0);
INSERT INTO `location` VALUES(1132, 'Despeñaderos', 124, 0);
INSERT INTO `location` VALUES(1133, 'Devoto', 124, 0);
INSERT INTO `location` VALUES(1134, 'El Arañado', 124, 0);
INSERT INTO `location` VALUES(1135, 'El Fortín', 124, 0);
INSERT INTO `location` VALUES(1136, 'El Tío', 124, 0);
INSERT INTO `location` VALUES(1137, 'Elena', 124, 0);
INSERT INTO `location` VALUES(1138, 'Embalse', 124, 0);
INSERT INTO `location` VALUES(1139, 'Etruria', 124, 0);
INSERT INTO `location` VALUES(1140, 'Freyre', 124, 0);
INSERT INTO `location` VALUES(1141, 'General Baldissera', 124, 0);
INSERT INTO `location` VALUES(1142, 'General Cabrera', 124, 0);
INSERT INTO `location` VALUES(1143, 'General Deheza', 124, 0);
INSERT INTO `location` VALUES(1144, 'General Lavalle', 124, 0);
INSERT INTO `location` VALUES(1145, 'General Paz', 124, 0);
INSERT INTO `location` VALUES(1146, 'General Roca', 124, 0);
INSERT INTO `location` VALUES(1147, 'General San Martin', 124, 0);
INSERT INTO `location` VALUES(1148, 'Guatimozín', 124, 0);
INSERT INTO `location` VALUES(1149, 'Hernando', 124, 0);
INSERT INTO `location` VALUES(1150, 'Hipólito Bouchard', 124, 0);
INSERT INTO `location` VALUES(1151, 'Huanchilla', 124, 0);
INSERT INTO `location` VALUES(1152, 'Huinca Renancó', 124, 0);
INSERT INTO `location` VALUES(1153, 'Idiazábal', 124, 0);
INSERT INTO `location` VALUES(1154, 'Inriville', 124, 0);
INSERT INTO `location` VALUES(1155, 'Ischilin', 124, 0);
INSERT INTO `location` VALUES(1156, 'Isla Verde', 124, 0);
INSERT INTO `location` VALUES(1157, 'James Craik', 124, 0);
INSERT INTO `location` VALUES(1158, 'Jesús María', 124, 0);
INSERT INTO `location` VALUES(1159, 'Juarez Celman', 124, 0);
INSERT INTO `location` VALUES(1160, 'Justiniano Posse', 124, 0);
INSERT INTO `location` VALUES(1161, 'La Calera', 124, 0);
INSERT INTO `location` VALUES(1162, 'La Carlota', 124, 0);
INSERT INTO `location` VALUES(1163, 'La Cautiva', 124, 0);
INSERT INTO `location` VALUES(1164, 'La Cesira', 124, 0);
INSERT INTO `location` VALUES(1165, 'La Cruz', 124, 0);
INSERT INTO `location` VALUES(1166, 'La Cumbre', 124, 0);
INSERT INTO `location` VALUES(1167, 'La Falda', 124, 0);
INSERT INTO `location` VALUES(1168, 'La Francia', 124, 0);
INSERT INTO `location` VALUES(1169, 'La Granja', 124, 0);
INSERT INTO `location` VALUES(1170, 'La Laguna', 124, 0);
INSERT INTO `location` VALUES(1171, 'La Paquita', 124, 0);
INSERT INTO `location` VALUES(1172, 'La Para', 124, 0);
INSERT INTO `location` VALUES(1173, 'La Paz', 124, 0);
INSERT INTO `location` VALUES(1174, 'La Playosa', 124, 0);
INSERT INTO `location` VALUES(1175, 'La Puerta ', 124, 0);
INSERT INTO `location` VALUES(1176, 'La Tordilla', 124, 0);
INSERT INTO `location` VALUES(1177, 'Laborde', 124, 0);
INSERT INTO `location` VALUES(1178, 'Laboulaye', 124, 0);
INSERT INTO `location` VALUES(1179, 'Laguna Larga', 124, 0);
INSERT INTO `location` VALUES(1180, 'Las Acequias', 124, 0);
INSERT INTO `location` VALUES(1181, 'Las Arrias', 124, 0);
INSERT INTO `location` VALUES(1182, 'Las Higueras', 124, 0);
INSERT INTO `location` VALUES(1183, 'Las Junturas', 124, 0);
INSERT INTO `location` VALUES(1184, 'Las Peñas', 124, 0);
INSERT INTO `location` VALUES(1185, 'Las Perdices', 124, 0);
INSERT INTO `location` VALUES(1186, 'Las Varas', 124, 0);
INSERT INTO `location` VALUES(1187, 'Las Varillas', 124, 0);
INSERT INTO `location` VALUES(1188, 'Las Vertientes', 124, 0);
INSERT INTO `location` VALUES(1189, 'Leones', 124, 0);
INSERT INTO `location` VALUES(1190, 'Los Cerrillos', 124, 0);
INSERT INTO `location` VALUES(1191, 'Los Cocos', 124, 0);
INSERT INTO `location` VALUES(1192, 'Los Cóndores', 124, 0);
INSERT INTO `location` VALUES(1193, 'Los Surgentes', 124, 0);
INSERT INTO `location` VALUES(1194, 'Lozada', 124, 0);
INSERT INTO `location` VALUES(1195, 'Lucio V. Mansilla', 124, 0);
INSERT INTO `location` VALUES(1196, 'Luque', 124, 0);
INSERT INTO `location` VALUES(1197, 'Luyaba', 124, 0);
INSERT INTO `location` VALUES(1198, 'Malagueño', 124, 0);
INSERT INTO `location` VALUES(1199, 'Manfredi', 124, 0);
INSERT INTO `location` VALUES(1200, 'Marcos Juarez', 124, 0);
INSERT INTO `location` VALUES(1201, 'Marull', 124, 0);
INSERT INTO `location` VALUES(1202, 'Matorrales', 124, 0);
INSERT INTO `location` VALUES(1203, 'Mattaldi', 124, 0);
INSERT INTO `location` VALUES(1204, 'Melo', 124, 0);
INSERT INTO `location` VALUES(1205, 'Mina Clavero', 124, 0);
INSERT INTO `location` VALUES(1206, 'Minas', 124, 0);
INSERT INTO `location` VALUES(1207, 'Miramar', 124, 0);
INSERT INTO `location` VALUES(1208, 'Monte Buey', 124, 0);
INSERT INTO `location` VALUES(1209, 'Monte Maíz', 124, 0);
INSERT INTO `location` VALUES(1210, 'Montecristo', 124, 0);
INSERT INTO `location` VALUES(1211, 'Morrison', 124, 0);
INSERT INTO `location` VALUES(1212, 'Morteros', 124, 0);
INSERT INTO `location` VALUES(1213, 'Noetinger', 124, 0);
INSERT INTO `location` VALUES(1214, 'Nono', 124, 0);
INSERT INTO `location` VALUES(1215, 'Obispo Trejo', 124, 0);
INSERT INTO `location` VALUES(1216, 'Oliva', 124, 0);
INSERT INTO `location` VALUES(1217, 'Oncativo', 124, 0);
INSERT INTO `location` VALUES(1218, 'Ordoñez', 124, 0);
INSERT INTO `location` VALUES(1219, 'Pampayasta Sur', 124, 0);
INSERT INTO `location` VALUES(1220, 'Pascanas', 124, 0);
INSERT INTO `location` VALUES(1221, 'Pasco', 124, 0);
INSERT INTO `location` VALUES(1222, 'Pilar', 124, 0);
INSERT INTO `location` VALUES(1223, 'Piquillín', 124, 0);
INSERT INTO `location` VALUES(1224, 'Pocho', 124, 0);
INSERT INTO `location` VALUES(1225, 'Porteña', 124, 0);
INSERT INTO `location` VALUES(1226, 'Pozo del Molle', 124, 0);
INSERT INTO `location` VALUES(1227, 'Pte Roque Saenz Peña', 124, 0);
INSERT INTO `location` VALUES(1228, 'Pueblo Italiano', 124, 0);
INSERT INTO `location` VALUES(1229, 'Punilla', 124, 0);
INSERT INTO `location` VALUES(1230, 'Quilino', 124, 0);
INSERT INTO `location` VALUES(1231, 'Río Ceballos', 124, 0);
INSERT INTO `location` VALUES(1232, 'Río de los Sauces', 124, 0);
INSERT INTO `location` VALUES(1233, 'Rio Primero', 124, 0);
INSERT INTO `location` VALUES(1234, 'Rio Seco', 124, 0);
INSERT INTO `location` VALUES(1235, 'Rio Segundo', 124, 0);
INSERT INTO `location` VALUES(1236, 'Río Tercero', 124, 0);
INSERT INTO `location` VALUES(1237, 'S. Temple', 124, 0);
INSERT INTO `location` VALUES(1238, 'Sacanta', 124, 0);
INSERT INTO `location` VALUES(1239, 'Saira', 124, 0);
INSERT INTO `location` VALUES(1240, 'Salsacate', 124, 0);
INSERT INTO `location` VALUES(1241, 'Salsipuedes', 124, 0);
INSERT INTO `location` VALUES(1242, 'Sampacho', 124, 0);
INSERT INTO `location` VALUES(1243, 'San Agustín', 124, 0);
INSERT INTO `location` VALUES(1244, 'San Alberto', 124, 0);
INSERT INTO `location` VALUES(1245, 'San Antonio de Arredondo', 124, 0);
INSERT INTO `location` VALUES(1246, 'San Antonio de Litín', 124, 0);
INSERT INTO `location` VALUES(1247, 'San Basilio', 124, 0);
INSERT INTO `location` VALUES(1248, 'San Carlos Minas', 124, 0);
INSERT INTO `location` VALUES(1249, 'San Esteban', 124, 0);
INSERT INTO `location` VALUES(1250, 'San Francisco', 124, 0);
INSERT INTO `location` VALUES(1251, 'San Javier', 124, 0);
INSERT INTO `location` VALUES(1252, 'San José', 124, 0);
INSERT INTO `location` VALUES(1253, 'San José de la Dormida', 124, 0);
INSERT INTO `location` VALUES(1254, 'San Justo', 124, 0);
INSERT INTO `location` VALUES(1255, 'San Pedro', 124, 0);
INSERT INTO `location` VALUES(1256, 'Santa Catalina', 124, 0);
INSERT INTO `location` VALUES(1257, 'Santa Eufemia', 124, 0);
INSERT INTO `location` VALUES(1258, 'Santa Rosa', 124, 0);
INSERT INTO `location` VALUES(1259, 'Santa Rosa de Calamuchita', 124, 0);
INSERT INTO `location` VALUES(1260, 'Santa Rosa del Río Primero', 124, 0);
INSERT INTO `location` VALUES(1261, 'Sarmiento', 124, 0);
INSERT INTO `location` VALUES(1262, 'Saturnino María Laspiur', 124, 0);
INSERT INTO `location` VALUES(1263, 'Sebastián Elcano', 124, 0);
INSERT INTO `location` VALUES(1264, 'Serrano', 124, 0);
INSERT INTO `location` VALUES(1265, 'Serrezuela', 124, 0);
INSERT INTO `location` VALUES(1266, 'Sobremonte', 124, 0);
INSERT INTO `location` VALUES(1267, 'Tancacha', 124, 0);
INSERT INTO `location` VALUES(1268, 'Tanti', 124, 0);
INSERT INTO `location` VALUES(1269, 'Tercero Arriba', 124, 0);
INSERT INTO `location` VALUES(1270, 'Ticino', 124, 0);
INSERT INTO `location` VALUES(1271, 'Tío Pujio', 124, 0);
INSERT INTO `location` VALUES(1272, 'Toledo', 124, 0);
INSERT INTO `location` VALUES(1273, 'Tortoral', 124, 0);
INSERT INTO `location` VALUES(1274, 'Tránsito', 124, 0);
INSERT INTO `location` VALUES(1275, 'Tuclame', 124, 0);
INSERT INTO `location` VALUES(1276, 'Tulumba', 124, 0);
INSERT INTO `location` VALUES(1277, 'Ucacha', 124, 0);
INSERT INTO `location` VALUES(1278, 'Union', 124, 0);
INSERT INTO `location` VALUES(1279, 'Unquillo', 124, 0);
INSERT INTO `location` VALUES(1280, 'Valle Hermoso', 124, 0);
INSERT INTO `location` VALUES(1281, 'Viamonte', 124, 0);
INSERT INTO `location` VALUES(1282, 'Vicuña Mackenna', 124, 0);
INSERT INTO `location` VALUES(1283, 'Villa Allende', 124, 0);
INSERT INTO `location` VALUES(1284, 'Villa Ascasubi', 124, 0);
INSERT INTO `location` VALUES(1285, 'Villa Carlos Paz', 124, 0);
INSERT INTO `location` VALUES(1286, 'Villa Concepción del Tío', 124, 0);
INSERT INTO `location` VALUES(1287, 'Villa Cura Brochero', 124, 0);
INSERT INTO `location` VALUES(1288, 'Villa de María', 124, 0);
INSERT INTO `location` VALUES(1289, 'Villa de Soto', 124, 0);
INSERT INTO `location` VALUES(1290, 'Villa del Dique', 124, 0);
INSERT INTO `location` VALUES(1291, 'Villa del Rosario', 124, 0);
INSERT INTO `location` VALUES(1292, 'Villa del Totoral', 124, 0);
INSERT INTO `location` VALUES(1293, 'Villa Dolores', 124, 0);
INSERT INTO `location` VALUES(1294, 'Villa Fontana', 124, 0);
INSERT INTO `location` VALUES(1295, 'Villa General Belgrano', 124, 0);
INSERT INTO `location` VALUES(1296, 'Villa Giardino', 124, 0);
INSERT INTO `location` VALUES(1297, 'Villa Gral. Belgrano', 124, 0);
INSERT INTO `location` VALUES(1298, 'Villa Huidobro', 124, 0);
INSERT INTO `location` VALUES(1299, 'Villa Maria', 124, 0);
INSERT INTO `location` VALUES(1300, 'Villa Nueva', 124, 0);
INSERT INTO `location` VALUES(1301, 'Villa Reducción', 124, 0);
INSERT INTO `location` VALUES(1302, 'Villa Rumipal', 124, 0);
INSERT INTO `location` VALUES(1303, 'Villa Tulumba', 124, 0);
INSERT INTO `location` VALUES(1304, 'Villa Valeria', 124, 0);
INSERT INTO `location` VALUES(1305, 'Washington', 124, 0);
INSERT INTO `location` VALUES(1306, 'Wenceslao Escalante', 124, 0);
INSERT INTO `location` VALUES(1307, 'Yacanto', 124, 0);
INSERT INTO `location` VALUES(1308, '9 de Julio', 125, 0);
INSERT INTO `location` VALUES(1309, 'Alvear', 125, 0);
INSERT INTO `location` VALUES(1310, 'Bella Vista', 125, 0);
INSERT INTO `location` VALUES(1311, 'Beron de Astrada', 125, 0);
INSERT INTO `location` VALUES(1312, 'Chavarría', 125, 0);
INSERT INTO `location` VALUES(1313, 'Colonia Carlos Pellegrini', 125, 0);
INSERT INTO `location` VALUES(1314, 'Colonia Liebig´s', 125, 0);
INSERT INTO `location` VALUES(1315, 'Concepcion', 125, 0);
INSERT INTO `location` VALUES(1316, 'Corrientes', 125, 0);
INSERT INTO `location` VALUES(1317, 'Curuzu Cuatia', 125, 0);
INSERT INTO `location` VALUES(1318, 'El Sombrero', 125, 0);
INSERT INTO `location` VALUES(1319, 'Empedrado', 125, 0);
INSERT INTO `location` VALUES(1320, 'Esquina', 125, 0);
INSERT INTO `location` VALUES(1321, 'Felipe Yofré', 125, 0);
INSERT INTO `location` VALUES(1322, 'Garruchos', 125, 0);
INSERT INTO `location` VALUES(1323, 'General Alvear', 125, 0);
INSERT INTO `location` VALUES(1324, 'General Paz', 125, 0);
INSERT INTO `location` VALUES(1325, 'Gobernador Ing. Valentín', 125, 0);
INSERT INTO `location` VALUES(1326, 'Gobernador Juan E. Martinez', 125, 0);
INSERT INTO `location` VALUES(1327, 'Goya', 125, 0);
INSERT INTO `location` VALUES(1328, 'Guaviravi', 125, 0);
INSERT INTO `location` VALUES(1329, 'Itati', 125, 0);
INSERT INTO `location` VALUES(1330, 'Ituzaingo', 125, 0);
INSERT INTO `location` VALUES(1331, 'La Cruz', 125, 0);
INSERT INTO `location` VALUES(1332, 'Laguna Brava', 125, 0);
INSERT INTO `location` VALUES(1333, 'Lavalle', 125, 0);
INSERT INTO `location` VALUES(1334, 'Libertador', 125, 0);
INSERT INTO `location` VALUES(1335, 'Loreto', 125, 0);
INSERT INTO `location` VALUES(1336, 'Mariano I. Loza', 125, 0);
INSERT INTO `location` VALUES(1337, 'Mburucuya', 125, 0);
INSERT INTO `location` VALUES(1338, 'Mercedes', 125, 0);
INSERT INTO `location` VALUES(1339, 'Mocoretá', 125, 0);
INSERT INTO `location` VALUES(1340, 'Monte Caseros', 125, 0);
INSERT INTO `location` VALUES(1341, 'Ntra. Señora del Rosario de Caa Catí', 125, 0);
INSERT INTO `location` VALUES(1342, 'Paso de la Patria', 125, 0);
INSERT INTO `location` VALUES(1343, 'Paso de los Libres', 125, 0);
INSERT INTO `location` VALUES(1344, 'Pedro R. Fernandez', 125, 0);
INSERT INTO `location` VALUES(1345, 'Perugorria', 125, 0);
INSERT INTO `location` VALUES(1346, 'Saladas', 125, 0);
INSERT INTO `location` VALUES(1347, 'San Carlos', 125, 0);
INSERT INTO `location` VALUES(1348, 'San Cosme', 125, 0);
INSERT INTO `location` VALUES(1349, 'San Lorenzo', 125, 0);
INSERT INTO `location` VALUES(1350, 'San Luis del Palmar', 125, 0);
INSERT INTO `location` VALUES(1351, 'San Martin', 125, 0);
INSERT INTO `location` VALUES(1352, 'San Miguel', 125, 0);
INSERT INTO `location` VALUES(1353, 'San Roque', 125, 0);
INSERT INTO `location` VALUES(1354, 'Santa Ana', 125, 0);
INSERT INTO `location` VALUES(1355, 'Santa Lucía', 125, 0);
INSERT INTO `location` VALUES(1356, 'Santa Rosa', 125, 0);
INSERT INTO `location` VALUES(1357, 'Santo Tome', 125, 0);
INSERT INTO `location` VALUES(1358, 'Sauce', 125, 0);
INSERT INTO `location` VALUES(1359, 'Virasoro', 125, 0);
INSERT INTO `location` VALUES(1360, 'Yapeyú', 125, 0);
INSERT INTO `location` VALUES(1361, 'Aldea Brasilera', 126, 0);
INSERT INTO `location` VALUES(1362, 'Aldea San Antonio', 126, 0);
INSERT INTO `location` VALUES(1363, 'Aldea Valle María', 126, 0);
INSERT INTO `location` VALUES(1364, 'Aranguren', 126, 0);
INSERT INTO `location` VALUES(1365, 'Basalvilbaso', 126, 0);
INSERT INTO `location` VALUES(1366, 'Bovril', 126, 0);
INSERT INTO `location` VALUES(1367, 'Calabacilla', 126, 0);
INSERT INTO `location` VALUES(1368, 'Caseros', 126, 0);
INSERT INTO `location` VALUES(1369, 'Cerrito', 126, 0);
INSERT INTO `location` VALUES(1370, 'Chajarí', 126, 0);
INSERT INTO `location` VALUES(1371, 'Colón', 126, 0);
INSERT INTO `location` VALUES(1372, 'Concep. Del Uruguay', 126, 0);
INSERT INTO `location` VALUES(1373, 'Concordia', 126, 0);
INSERT INTO `location` VALUES(1374, 'Conscripto Bernardi', 126, 0);
INSERT INTO `location` VALUES(1375, 'Costa del Uruguay', 126, 0);
INSERT INTO `location` VALUES(1376, 'Crespo', 126, 0);
INSERT INTO `location` VALUES(1377, 'Diamante', 126, 0);
INSERT INTO `location` VALUES(1378, 'Domínguez', 126, 0);
INSERT INTO `location` VALUES(1379, 'El Brillante', 126, 0);
INSERT INTO `location` VALUES(1380, 'El Pingo', 126, 0);
INSERT INTO `location` VALUES(1381, 'Enrique Carbó', 126, 0);
INSERT INTO `location` VALUES(1382, 'Federacion', 126, 0);
INSERT INTO `location` VALUES(1383, 'Federal', 126, 0);
INSERT INTO `location` VALUES(1384, 'Feliciano', 126, 0);
INSERT INTO `location` VALUES(1385, 'General Campos', 126, 0);
INSERT INTO `location` VALUES(1386, 'General Galarza', 126, 0);
INSERT INTO `location` VALUES(1387, 'Gilbert', 126, 0);
INSERT INTO `location` VALUES(1388, 'Gobernador Mansilla', 126, 0);
INSERT INTO `location` VALUES(1389, 'Gualeguay', 126, 0);
INSERT INTO `location` VALUES(1390, 'Gualeguaychú', 126, 0);
INSERT INTO `location` VALUES(1391, 'Hasenkamp', 126, 0);
INSERT INTO `location` VALUES(1392, 'Hernandarias', 126, 0);
INSERT INTO `location` VALUES(1393, 'Hernández', 126, 0);
INSERT INTO `location` VALUES(1394, 'Ibicuy', 126, 0);
INSERT INTO `location` VALUES(1395, 'Jubileo', 126, 0);
INSERT INTO `location` VALUES(1396, 'La Criolla', 126, 0);
INSERT INTO `location` VALUES(1397, 'La Paz', 126, 0);
INSERT INTO `location` VALUES(1398, 'Larroque', 126, 0);
INSERT INTO `location` VALUES(1399, 'Libertador San Martín', 126, 0);
INSERT INTO `location` VALUES(1400, 'Los Charrúas', 126, 0);
INSERT INTO `location` VALUES(1401, 'Los Conquistadores', 126, 0);
INSERT INTO `location` VALUES(1402, 'Lucas Ganzáles', 126, 0);
INSERT INTO `location` VALUES(1403, 'Macía', 126, 0);
INSERT INTO `location` VALUES(1404, 'María Grande', 126, 0);
INSERT INTO `location` VALUES(1405, 'Nogoya', 126, 0);
INSERT INTO `location` VALUES(1406, 'Oro Verde', 126, 0);
INSERT INTO `location` VALUES(1407, 'Osvaldo Magnasco', 126, 0);
INSERT INTO `location` VALUES(1408, 'Parana', 126, 0);
INSERT INTO `location` VALUES(1409, 'Piedras Blancas', 126, 0);
INSERT INTO `location` VALUES(1410, 'Pronunciamiento', 126, 0);
INSERT INTO `location` VALUES(1411, 'Pt. Yeruá', 126, 0);
INSERT INTO `location` VALUES(1412, 'Pueblo Arrúa', 126, 0);
INSERT INTO `location` VALUES(1413, 'Pueblo Brugo', 126, 0);
INSERT INTO `location` VALUES(1414, 'Pueblo Cazés', 126, 0);
INSERT INTO `location` VALUES(1415, 'Rosario del Tala', 126, 0);
INSERT INTO `location` VALUES(1416, 'San Benito', 126, 0);
INSERT INTO `location` VALUES(1417, 'San Gustavo', 126, 0);
INSERT INTO `location` VALUES(1418, 'San Jaime de la Frontera', 126, 0);
INSERT INTO `location` VALUES(1419, 'San José', 126, 0);
INSERT INTO `location` VALUES(1420, 'San José de Feliciano', 126, 0);
INSERT INTO `location` VALUES(1421, 'San Martin', 126, 0);
INSERT INTO `location` VALUES(1422, 'San Salvador', 126, 0);
INSERT INTO `location` VALUES(1423, 'Santa Ana', 126, 0);
INSERT INTO `location` VALUES(1424, 'Santa Anita', 126, 0);
INSERT INTO `location` VALUES(1425, 'Santa Elena', 126, 0);
INSERT INTO `location` VALUES(1426, 'Sauce de Luna', 126, 0);
INSERT INTO `location` VALUES(1427, 'Seguí', 126, 0);
INSERT INTO `location` VALUES(1428, 'Strobel', 126, 0);
INSERT INTO `location` VALUES(1429, 'Tabossi', 126, 0);
INSERT INTO `location` VALUES(1430, 'Tala', 126, 0);
INSERT INTO `location` VALUES(1431, 'Ubajay', 126, 0);
INSERT INTO `location` VALUES(1432, 'Urdinarrain', 126, 0);
INSERT INTO `location` VALUES(1433, 'Uruguay', 126, 0);
INSERT INTO `location` VALUES(1434, 'Victoria', 126, 0);
INSERT INTO `location` VALUES(1435, 'Villa Clara', 126, 0);
INSERT INTO `location` VALUES(1436, 'Villa Paranacito', 126, 0);
INSERT INTO `location` VALUES(1437, 'Villa Urquiza', 126, 0);
INSERT INTO `location` VALUES(1438, 'Villaguay', 126, 0);
INSERT INTO `location` VALUES(1439, 'Bermejo', 127, 0);
INSERT INTO `location` VALUES(1440, 'Buena Vista', 127, 0);
INSERT INTO `location` VALUES(1441, 'Clorinda', 127, 0);
INSERT INTO `location` VALUES(1442, 'Colonia Pastoril', 127, 0);
INSERT INTO `location` VALUES(1443, 'Comandante Fontana', 127, 0);
INSERT INTO `location` VALUES(1444, 'El Colorado', 127, 0);
INSERT INTO `location` VALUES(1445, 'Espinillo', 127, 0);
INSERT INTO `location` VALUES(1446, 'Estanislao del Campo', 127, 0);
INSERT INTO `location` VALUES(1447, 'Fn. Cabo 1º Lugones', 127, 0);
INSERT INTO `location` VALUES(1448, 'Ciudad de Formosa', 127, 0);
INSERT INTO `location` VALUES(1449, 'Gral. Lucio Victorio Mansilla', 127, 0);
INSERT INTO `location` VALUES(1450, 'Gral. Mosconi', 127, 0);
INSERT INTO `location` VALUES(1451, 'Gran Guardia', 127, 0);
INSERT INTO `location` VALUES(1452, 'Herradura', 127, 0);
INSERT INTO `location` VALUES(1453, 'Ibarreta', 127, 0);
INSERT INTO `location` VALUES(1454, 'Ing. Guillermo N. Juárez', 127, 0);
INSERT INTO `location` VALUES(1455, 'Laguna Blanca', 127, 0);
INSERT INTO `location` VALUES(1456, 'Laguna Yema', 127, 0);
INSERT INTO `location` VALUES(1457, 'Laishi', 127, 0);
INSERT INTO `location` VALUES(1458, 'Las Lomitas', 127, 0);
INSERT INTO `location` VALUES(1459, 'Los Chiriguanos', 127, 0);
INSERT INTO `location` VALUES(1460, 'Matacos', 127, 0);
INSERT INTO `location` VALUES(1461, 'Mayor Villafañe', 127, 0);
INSERT INTO `location` VALUES(1462, 'Misión Tacaaglé', 127, 0);
INSERT INTO `location` VALUES(1463, 'Palo Santo', 127, 0);
INSERT INTO `location` VALUES(1464, 'Patiño', 127, 0);
INSERT INTO `location` VALUES(1465, 'Pilagas', 127, 0);
INSERT INTO `location` VALUES(1466, 'Pilcomayo', 127, 0);
INSERT INTO `location` VALUES(1467, 'Pirane', 127, 0);
INSERT INTO `location` VALUES(1468, 'Pozo del Tigre', 127, 0);
INSERT INTO `location` VALUES(1469, 'Ramon Lista', 127, 0);
INSERT INTO `location` VALUES(1470, 'Riacho He-He', 127, 0);
INSERT INTO `location` VALUES(1471, 'San Francisco de Laishi', 127, 0);
INSERT INTO `location` VALUES(1472, 'San Martín II', 127, 0);
INSERT INTO `location` VALUES(1473, 'Tres Lagunas', 127, 0);
INSERT INTO `location` VALUES(1474, 'Villa Dos Trece', 127, 0);
INSERT INTO `location` VALUES(1475, 'Villa Escolar', 127, 0);
INSERT INTO `location` VALUES(1476, 'Villa General Guemes', 127, 0);
INSERT INTO `location` VALUES(1477, 'Villa General Manuel Belgrano', 127, 0);
INSERT INTO `location` VALUES(1478, 'Abra Pampa', 128, 0);
INSERT INTO `location` VALUES(1479, 'Barrio Negro', 128, 0);
INSERT INTO `location` VALUES(1480, 'Caimancito', 128, 0);
INSERT INTO `location` VALUES(1481, 'Calilegua', 128, 0);
INSERT INTO `location` VALUES(1482, 'Chalicán', 128, 0);
INSERT INTO `location` VALUES(1483, 'Cochinoca', 128, 0);
INSERT INTO `location` VALUES(1484, 'Dr. Manuel Belgrano', 128, 0);
INSERT INTO `location` VALUES(1485, 'El Aguilar', 128, 0);
INSERT INTO `location` VALUES(1486, 'El Carmen', 128, 0);
INSERT INTO `location` VALUES(1487, 'El Piquete', 128, 0);
INSERT INTO `location` VALUES(1488, 'El Talar', 128, 0);
INSERT INTO `location` VALUES(1489, 'Fraile Pintado', 128, 0);
INSERT INTO `location` VALUES(1490, 'Humahuaca', 128, 0);
INSERT INTO `location` VALUES(1491, 'La Mendieta', 128, 0);
INSERT INTO `location` VALUES(1492, 'La Quiaca', 128, 0);
INSERT INTO `location` VALUES(1493, 'Ledesma', 128, 0);
INSERT INTO `location` VALUES(1494, 'Libertador Gral. San Martín', 128, 0);
INSERT INTO `location` VALUES(1495, 'Los Lapachos', 128, 0);
INSERT INTO `location` VALUES(1496, 'Lozano', 128, 0);
INSERT INTO `location` VALUES(1497, 'Maimará', 128, 0);
INSERT INTO `location` VALUES(1498, 'Mina Pirquitas', 128, 0);
INSERT INTO `location` VALUES(1499, 'Monterrico', 128, 0);
INSERT INTO `location` VALUES(1500, 'Palma Sola', 128, 0);
INSERT INTO `location` VALUES(1501, 'Palpala', 128, 0);
INSERT INTO `location` VALUES(1502, 'Pampa Blanca', 128, 0);
INSERT INTO `location` VALUES(1503, 'Perico', 128, 0);
INSERT INTO `location` VALUES(1504, 'Puesto Viejo', 128, 0);
INSERT INTO `location` VALUES(1505, 'Rinconada', 128, 0);
INSERT INTO `location` VALUES(1506, 'San Antonio', 128, 0);
INSERT INTO `location` VALUES(1507, 'San Pedro', 128, 0);
INSERT INTO `location` VALUES(1508, 'San Salvador de Jujuy', 128, 0);
INSERT INTO `location` VALUES(1509, 'Santa Barbara', 128, 0);
INSERT INTO `location` VALUES(1510, 'Santa Catalina', 128, 0);
INSERT INTO `location` VALUES(1511, 'Santa Clara', 128, 0);
INSERT INTO `location` VALUES(1512, 'Susques', 128, 0);
INSERT INTO `location` VALUES(1513, 'Tilcara', 128, 0);
INSERT INTO `location` VALUES(1514, 'Tres Cruces', 128, 0);
INSERT INTO `location` VALUES(1515, 'Tumbaya', 128, 0);
INSERT INTO `location` VALUES(1516, 'Valle Grande', 128, 0);
INSERT INTO `location` VALUES(1517, 'Volcán', 128, 0);
INSERT INTO `location` VALUES(1518, 'Yala ', 128, 0);
INSERT INTO `location` VALUES(1519, 'Yavi', 128, 0);
INSERT INTO `location` VALUES(1520, 'Yuto', 128, 0);
INSERT INTO `location` VALUES(1521, '25 de Mayo', 129, 0);
INSERT INTO `location` VALUES(1522, 'Algarrobo del Aguila', 129, 0);
INSERT INTO `location` VALUES(1523, 'Alpachiri', 129, 0);
INSERT INTO `location` VALUES(1524, 'Alta Italia', 129, 0);
INSERT INTO `location` VALUES(1525, 'Anguil', 129, 0);
INSERT INTO `location` VALUES(1526, 'Arata', 129, 0);
INSERT INTO `location` VALUES(1527, 'Atreuco', 129, 0);
INSERT INTO `location` VALUES(1528, 'Bernasconi', 129, 0);
INSERT INTO `location` VALUES(1529, 'Caleu Caleu', 129, 0);
INSERT INTO `location` VALUES(1530, 'Caleufú', 129, 0);
INSERT INTO `location` VALUES(1531, 'Catrilo', 129, 0);
INSERT INTO `location` VALUES(1532, 'Chalileo', 129, 0);
INSERT INTO `location` VALUES(1533, 'Chapaleufu', 129, 0);
INSERT INTO `location` VALUES(1534, 'Chical Co', 129, 0);
INSERT INTO `location` VALUES(1535, 'Colonia Barón', 129, 0);
INSERT INTO `location` VALUES(1536, 'Conhelo', 129, 0);
INSERT INTO `location` VALUES(1537, 'Cuchillo Co', 129, 0);
INSERT INTO `location` VALUES(1538, 'Curaco', 129, 0);
INSERT INTO `location` VALUES(1539, 'Doblas', 129, 0);
INSERT INTO `location` VALUES(1540, 'Eduardo Castex', 129, 0);
INSERT INTO `location` VALUES(1541, 'Embajador Martini', 129, 0);
INSERT INTO `location` VALUES(1542, 'General Acha', 129, 0);
INSERT INTO `location` VALUES(1543, 'General Manuel J. Campos', 129, 0);
INSERT INTO `location` VALUES(1544, 'General Pico', 129, 0);
INSERT INTO `location` VALUES(1545, 'General San Martín', 129, 0);
INSERT INTO `location` VALUES(1546, 'Guatraché', 129, 0);
INSERT INTO `location` VALUES(1547, 'Hucal', 129, 0);
INSERT INTO `location` VALUES(1548, 'Ing. Luiggi', 129, 0);
INSERT INTO `location` VALUES(1549, 'Intendente Alvear', 129, 0);
INSERT INTO `location` VALUES(1550, 'Jacinto Aráuz', 129, 0);
INSERT INTO `location` VALUES(1551, 'La Adela', 129, 0);
INSERT INTO `location` VALUES(1552, 'La Maruja', 129, 0);
INSERT INTO `location` VALUES(1553, 'Limay Mahuida', 129, 0);
INSERT INTO `location` VALUES(1554, 'Lonquimay', 129, 0);
INSERT INTO `location` VALUES(1555, 'Loventue', 129, 0);
INSERT INTO `location` VALUES(1556, 'Luan Toro', 129, 0);
INSERT INTO `location` VALUES(1557, 'M. Cané', 129, 0);
INSERT INTO `location` VALUES(1558, 'M. Riglos', 129, 0);
INSERT INTO `location` VALUES(1559, 'Macachín', 129, 0);
INSERT INTO `location` VALUES(1560, 'Maraco', 129, 0);
INSERT INTO `location` VALUES(1561, 'Metileo', 129, 0);
INSERT INTO `location` VALUES(1562, 'Monte Nievas', 129, 0);
INSERT INTO `location` VALUES(1563, 'Perera', 129, 0);
INSERT INTO `location` VALUES(1564, 'Puelches', 129, 0);
INSERT INTO `location` VALUES(1565, 'Puelen', 129, 0);
INSERT INTO `location` VALUES(1566, 'Quemu Quemu', 129, 0);
INSERT INTO `location` VALUES(1567, 'Rancul', 129, 0);
INSERT INTO `location` VALUES(1568, 'Realico', 129, 0);
INSERT INTO `location` VALUES(1569, 'Rolón', 129, 0);
INSERT INTO `location` VALUES(1570, 'Santa Isabel', 129, 0);
INSERT INTO `location` VALUES(1571, 'Santa Rosa', 129, 0);
INSERT INTO `location` VALUES(1572, 'Santa Teresa', 129, 0);
INSERT INTO `location` VALUES(1573, 'Telén', 129, 0);
INSERT INTO `location` VALUES(1574, 'Toay', 129, 0);
INSERT INTO `location` VALUES(1575, 'Trenel', 129, 0);
INSERT INTO `location` VALUES(1576, 'Uhuel Calel', 129, 0);
INSERT INTO `location` VALUES(1577, 'Uriburu', 129, 0);
INSERT INTO `location` VALUES(1578, 'Utracan', 129, 0);
INSERT INTO `location` VALUES(1579, 'Vértiz', 129, 0);
INSERT INTO `location` VALUES(1580, 'Victoria', 129, 0);
INSERT INTO `location` VALUES(1581, 'Villa Mirasol', 129, 0);
INSERT INTO `location` VALUES(1582, 'Winifreda', 129, 0);
INSERT INTO `location` VALUES(1583, 'Agua Blanca', 130, 0);
INSERT INTO `location` VALUES(1584, 'Aguayo', 130, 0);
INSERT INTO `location` VALUES(1585, 'Aicuña', 130, 0);
INSERT INTO `location` VALUES(1586, 'Aimogasta', 130, 0);
INSERT INTO `location` VALUES(1587, 'Alpasincha', 130, 0);
INSERT INTO `location` VALUES(1588, 'Amaná', 130, 0);
INSERT INTO `location` VALUES(1589, 'Ambil', 130, 0);
INSERT INTO `location` VALUES(1590, 'Aminga', 130, 0);
INSERT INTO `location` VALUES(1591, 'Anguinán', 130, 0);
INSERT INTO `location` VALUES(1592, 'Anillaco', 130, 0);
INSERT INTO `location` VALUES(1593, 'Arauco', 130, 0);
INSERT INTO `location` VALUES(1594, 'Banda Florida', 130, 0);
INSERT INTO `location` VALUES(1595, 'Campanas', 130, 0);
INSERT INTO `location` VALUES(1596, 'Castro Barros', 130, 0);
INSERT INTO `location` VALUES(1597, 'Cebollar', 130, 0);
INSERT INTO `location` VALUES(1598, 'Chamical', 130, 0);
INSERT INTO `location` VALUES(1599, 'Chañar', 130, 0);
INSERT INTO `location` VALUES(1600, 'Chepes', 130, 0);
INSERT INTO `location` VALUES(1601, 'Chilecito', 130, 0);
INSERT INTO `location` VALUES(1602, 'Chuquis', 130, 0);
INSERT INTO `location` VALUES(1603, 'Corral de Isaac', 130, 0);
INSERT INTO `location` VALUES(1604, 'Desiderio Tello', 130, 0);
INSERT INTO `location` VALUES(1605, 'El Carrizal', 130, 0);
INSERT INTO `location` VALUES(1606, 'El Potrerillo', 130, 0);
INSERT INTO `location` VALUES(1607, 'El Totoral', 130, 0);
INSERT INTO `location` VALUES(1608, 'Famatina', 130, 0);
INSERT INTO `location` VALUES(1609, 'Guandacol', 130, 0);
INSERT INTO `location` VALUES(1610, 'La Banda', 130, 0);
INSERT INTO `location` VALUES(1611, 'La Cuadra', 130, 0);
INSERT INTO `location` VALUES(1612, 'Loma Blanca', 130, 0);
INSERT INTO `location` VALUES(1613, 'Los Aguirres', 130, 0);
INSERT INTO `location` VALUES(1614, 'Los Molinos', 130, 0);
INSERT INTO `location` VALUES(1615, 'Los Palacios', 130, 0);
INSERT INTO `location` VALUES(1616, 'Los Robles', 130, 0);
INSERT INTO `location` VALUES(1617, 'Malanzán', 130, 0);
INSERT INTO `location` VALUES(1618, 'Malligasta', 130, 0);
INSERT INTO `location` VALUES(1619, 'Milagro', 130, 0);
INSERT INTO `location` VALUES(1620, 'Nonogasta', 130, 0);
INSERT INTO `location` VALUES(1621, 'Olta', 130, 0);
INSERT INTO `location` VALUES(1622, 'Pagancillo', 130, 0);
INSERT INTO `location` VALUES(1623, 'Patquía', 130, 0);
INSERT INTO `location` VALUES(1624, 'Pituil', 130, 0);
INSERT INTO `location` VALUES(1625, 'San Pedro', 130, 0);
INSERT INTO `location` VALUES(1626, 'Sañogasta', 130, 0);
INSERT INTO `location` VALUES(1627, 'Santa Clara', 130, 0);
INSERT INTO `location` VALUES(1628, 'Santa Rita de Catuna', 130, 0);
INSERT INTO `location` VALUES(1629, 'Santa vera Cruz', 130, 0);
INSERT INTO `location` VALUES(1630, 'Saolica', 130, 0);
INSERT INTO `location` VALUES(1631, 'Talamuyuna', 130, 0);
INSERT INTO `location` VALUES(1632, 'Tama', 130, 0);
INSERT INTO `location` VALUES(1633, 'Tilmuaqui', 130, 0);
INSERT INTO `location` VALUES(1634, 'Ulapes', 130, 0);
INSERT INTO `location` VALUES(1635, 'Vichigasta', 130, 0);
INSERT INTO `location` VALUES(1636, 'Villa Castelli', 130, 0);
INSERT INTO `location` VALUES(1637, 'Villa Mazán', 130, 0);
INSERT INTO `location` VALUES(1638, 'Villa San José de Vinchina', 130, 0);
INSERT INTO `location` VALUES(1639, 'Villa Sanagasta', 130, 0);
INSERT INTO `location` VALUES(1640, 'Villa Unión', 130, 0);
INSERT INTO `location` VALUES(1641, 'Vinchina', 130, 0);
INSERT INTO `location` VALUES(1642, '25 de Mayo', 131, 0);
INSERT INTO `location` VALUES(1643, 'Agrelo', 131, 0);
INSERT INTO `location` VALUES(1644, 'Alto Verde', 131, 0);
INSERT INTO `location` VALUES(1645, 'Bowen', 131, 0);
INSERT INTO `location` VALUES(1646, 'Campo Los Andes', 131, 0);
INSERT INTO `location` VALUES(1647, 'Carmensa', 131, 0);
INSERT INTO `location` VALUES(1648, 'Chacras de Coria', 131, 0);
INSERT INTO `location` VALUES(1649, 'Chapanay', 131, 0);
INSERT INTO `location` VALUES(1650, 'Chilecito', 131, 0);
INSERT INTO `location` VALUES(1651, 'Colonia Las Rosas', 131, 0);
INSERT INTO `location` VALUES(1652, 'Cordón del Plata', 131, 0);
INSERT INTO `location` VALUES(1653, 'Costa de Araujo', 131, 0);
INSERT INTO `location` VALUES(1654, 'Cuadro Bombal', 131, 0);
INSERT INTO `location` VALUES(1655, 'El Nihuil', 131, 0);
INSERT INTO `location` VALUES(1656, 'Eugenio Bustos', 131, 0);
INSERT INTO `location` VALUES(1657, 'Ezeiza', 131, 0);
INSERT INTO `location` VALUES(1658, 'General Alvear', 131, 0);
INSERT INTO `location` VALUES(1659, 'Godoy Cruz', 131, 0);
INSERT INTO `location` VALUES(1660, 'Goudge', 131, 0);
INSERT INTO `location` VALUES(1661, 'Gral. Alvear', 131, 0);
INSERT INTO `location` VALUES(1662, 'Gral. Gutiérrez', 131, 0);
INSERT INTO `location` VALUES(1663, 'Guaymallén', 131, 0);
INSERT INTO `location` VALUES(1664, 'Junin', 131, 0);
INSERT INTO `location` VALUES(1665, 'La Consulta', 131, 0);
INSERT INTO `location` VALUES(1666, 'La Dormida', 131, 0);
INSERT INTO `location` VALUES(1667, 'La Paz', 131, 0);
INSERT INTO `location` VALUES(1668, 'Las Catitas', 131, 0);
INSERT INTO `location` VALUES(1669, 'Las Cuevas', 131, 0);
INSERT INTO `location` VALUES(1670, 'Las Heras', 131, 0);
INSERT INTO `location` VALUES(1671, 'Las Leñas', 131, 0);
INSERT INTO `location` VALUES(1672, 'Las Paredes', 131, 0);
INSERT INTO `location` VALUES(1673, 'Lavalle', 131, 0);
INSERT INTO `location` VALUES(1674, 'Lujan de Cuyo', 131, 0);
INSERT INTO `location` VALUES(1675, 'Maipu', 131, 0);
INSERT INTO `location` VALUES(1676, 'Malargüe', 131, 0);
INSERT INTO `location` VALUES(1677, 'Medrano', 131, 0);
INSERT INTO `location` VALUES(1678, 'Monte Comán', 131, 0);
INSERT INTO `location` VALUES(1679, 'Pareditas', 131, 0);
INSERT INTO `location` VALUES(1680, 'Perdriel', 131, 0);
INSERT INTO `location` VALUES(1681, 'Rama Caída', 131, 0);
INSERT INTO `location` VALUES(1682, 'Real del Padre', 131, 0);
INSERT INTO `location` VALUES(1683, 'Rivadavia', 131, 0);
INSERT INTO `location` VALUES(1684, 'Rodeo del Medio', 131, 0);
INSERT INTO `location` VALUES(1685, 'Salto de las Rosas', 131, 0);
INSERT INTO `location` VALUES(1686, 'San Carlos', 131, 0);
INSERT INTO `location` VALUES(1687, 'San José', 131, 0);
INSERT INTO `location` VALUES(1688, 'San Martin', 131, 0);
INSERT INTO `location` VALUES(1689, 'San Rafael', 131, 0);
INSERT INTO `location` VALUES(1690, 'Santa Rosa', 131, 0);
INSERT INTO `location` VALUES(1691, 'Tres Porteñas', 131, 0);
INSERT INTO `location` VALUES(1692, 'Tunuyan', 131, 0);
INSERT INTO `location` VALUES(1693, 'Tupungato', 131, 0);
INSERT INTO `location` VALUES(1694, 'Ugarteche', 131, 0);
INSERT INTO `location` VALUES(1695, 'Uspallata', 131, 0);
INSERT INTO `location` VALUES(1696, 'Villa Atuel', 131, 0);
INSERT INTO `location` VALUES(1697, 'Villa Bastia', 131, 0);
INSERT INTO `location` VALUES(1698, 'Villa Nueva', 131, 0);
INSERT INTO `location` VALUES(1699, 'Vista Flores', 131, 0);
INSERT INTO `location` VALUES(1700, '25 De Mayo', 132, 0);
INSERT INTO `location` VALUES(1701, '9 de Julio ', 132, 0);
INSERT INTO `location` VALUES(1702, 'Alba Posse', 132, 0);
INSERT INTO `location` VALUES(1703, 'Andresito', 132, 0);
INSERT INTO `location` VALUES(1704, 'Apostoles', 132, 0);
INSERT INTO `location` VALUES(1705, 'Aristóbulo del Valle', 132, 0);
INSERT INTO `location` VALUES(1706, 'Azara', 132, 0);
INSERT INTO `location` VALUES(1707, 'Bernardo de Yrigoyen', 132, 0);
INSERT INTO `location` VALUES(1708, 'Bompland', 132, 0);
INSERT INTO `location` VALUES(1709, 'Cainguas', 132, 0);
INSERT INTO `location` VALUES(1710, 'Campo Grande', 132, 0);
INSERT INTO `location` VALUES(1711, 'Campo Ramón', 132, 0);
INSERT INTO `location` VALUES(1712, 'Campo Viera', 132, 0);
INSERT INTO `location` VALUES(1713, 'Candelaria', 132, 0);
INSERT INTO `location` VALUES(1714, 'Capioví', 132, 0);
INSERT INTO `location` VALUES(1715, 'Cerro Azul', 132, 0);
INSERT INTO `location` VALUES(1716, 'Concepcion', 132, 0);
INSERT INTO `location` VALUES(1717, 'Corpus', 132, 0);
INSERT INTO `location` VALUES(1718, 'Dos de Mayo', 132, 0);
INSERT INTO `location` VALUES(1719, 'El Alcázar', 132, 0);
INSERT INTO `location` VALUES(1720, 'El Dorado', 132, 0);
INSERT INTO `location` VALUES(1721, 'El Soberbio', 132, 0);
INSERT INTO `location` VALUES(1722, 'Eldorado', 132, 0);
INSERT INTO `location` VALUES(1723, 'Esperanza', 132, 0);
INSERT INTO `location` VALUES(1724, 'Est. Apóstoles', 132, 0);
INSERT INTO `location` VALUES(1725, 'Garuhapé', 132, 0);
INSERT INTO `location` VALUES(1726, 'Garupá', 132, 0);
INSERT INTO `location` VALUES(1727, 'Gobernador Roca', 132, 0);
INSERT INTO `location` VALUES(1728, 'Gral Manuel Belgrano', 132, 0);
INSERT INTO `location` VALUES(1729, 'Guarani', 132, 0);
INSERT INTO `location` VALUES(1730, 'Iguazu', 132, 0);
INSERT INTO `location` VALUES(1731, 'Itacaruapé', 132, 0);
INSERT INTO `location` VALUES(1732, 'Jardín América', 132, 0);
INSERT INTO `location` VALUES(1733, 'KM. 26', 132, 0);
INSERT INTO `location` VALUES(1734, 'Km. 8', 132, 0);
INSERT INTO `location` VALUES(1735, 'Laharrague', 132, 0);
INSERT INTO `location` VALUES(1736, 'Ldor Gral San Martin', 132, 0);
INSERT INTO `location` VALUES(1737, 'Leandro N. Alem', 132, 0);
INSERT INTO `location` VALUES(1738, 'Libertad', 132, 0);
INSERT INTO `location` VALUES(1739, 'Los Helechos', 132, 0);
INSERT INTO `location` VALUES(1740, 'María Magdalena', 132, 0);
INSERT INTO `location` VALUES(1741, 'Montecarlo', 132, 0);
INSERT INTO `location` VALUES(1742, 'Oasis', 132, 0);
INSERT INTO `location` VALUES(1743, 'Obera', 132, 0);
INSERT INTO `location` VALUES(1744, 'Panambí', 132, 0);
INSERT INTO `location` VALUES(1745, 'Pindapoy', 132, 0);
INSERT INTO `location` VALUES(1746, 'Posadas', 132, 0);
INSERT INTO `location` VALUES(1747, 'Puerto Iguazú', 132, 0);
INSERT INTO `location` VALUES(1748, 'Puerto Leoni', 132, 0);
INSERT INTO `location` VALUES(1749, 'Puerto Pinares', 132, 0);
INSERT INTO `location` VALUES(1750, 'Puerto Piray', 132, 0);
INSERT INTO `location` VALUES(1751, 'Puerto Rico', 132, 0);
INSERT INTO `location` VALUES(1752, 'Ruiz de Montoya', 132, 0);
INSERT INTO `location` VALUES(1753, 'Salto Encantado', 132, 0);
INSERT INTO `location` VALUES(1754, 'San Antonio', 132, 0);
INSERT INTO `location` VALUES(1755, 'San Gortardo', 132, 0);
INSERT INTO `location` VALUES(1756, 'San Ignacio', 132, 0);
INSERT INTO `location` VALUES(1757, 'San Javier', 132, 0);
INSERT INTO `location` VALUES(1758, 'San José', 132, 0);
INSERT INTO `location` VALUES(1759, 'San Martín', 132, 0);
INSERT INTO `location` VALUES(1760, 'San Miguel', 132, 0);
INSERT INTO `location` VALUES(1761, 'San Pedro', 132, 0);
INSERT INTO `location` VALUES(1762, 'San Vicente', 132, 0);
INSERT INTO `location` VALUES(1763, 'Santa Ana', 132, 0);
INSERT INTO `location` VALUES(1764, 'Santa Rita', 132, 0);
INSERT INTO `location` VALUES(1765, 'Santo Pipó', 132, 0);
INSERT INTO `location` VALUES(1766, 'Turumá', 132, 0);
INSERT INTO `location` VALUES(1767, 'Victoria', 132, 0);
INSERT INTO `location` VALUES(1768, 'Villa Bonita', 132, 0);
INSERT INTO `location` VALUES(1769, 'Wanda', 132, 0);
INSERT INTO `location` VALUES(1770, 'Alumine', 133, 0);
INSERT INTO `location` VALUES(1771, 'Andacollo', 133, 0);
INSERT INTO `location` VALUES(1772, 'Añelo', 133, 0);
INSERT INTO `location` VALUES(1773, 'Arroyito', 133, 0);
INSERT INTO `location` VALUES(1774, 'Buta Ranquil', 133, 0);
INSERT INTO `location` VALUES(1775, 'Catan Lil', 133, 0);
INSERT INTO `location` VALUES(1776, 'Caviahué', 133, 0);
INSERT INTO `location` VALUES(1777, 'Centenario', 133, 0);
INSERT INTO `location` VALUES(1778, 'Chos Malal', 133, 0);
INSERT INTO `location` VALUES(1779, 'Collon Cura', 133, 0);
INSERT INTO `location` VALUES(1780, 'Confluencia', 133, 0);
INSERT INTO `location` VALUES(1781, 'Cutral Có', 133, 0);
INSERT INTO `location` VALUES(1782, 'El Huecú', 133, 0);
INSERT INTO `location` VALUES(1783, 'Huiliches', 133, 0);
INSERT INTO `location` VALUES(1784, 'Junin de los Andes', 133, 0);
INSERT INTO `location` VALUES(1785, 'Lacar', 133, 0);
INSERT INTO `location` VALUES(1786, 'Las Lajas', 133, 0);
INSERT INTO `location` VALUES(1787, 'Las Ovejas', 133, 0);
INSERT INTO `location` VALUES(1788, 'Loncopue', 133, 0);
INSERT INTO `location` VALUES(1789, 'Los Lagos', 133, 0);
INSERT INTO `location` VALUES(1790, 'Mariano Moreno', 133, 0);
INSERT INTO `location` VALUES(1791, 'Minas', 133, 0);
INSERT INTO `location` VALUES(1792, 'Neuquén', 133, 0);
INSERT INTO `location` VALUES(1793, 'Ñorquinco', 133, 0);
INSERT INTO `location` VALUES(1794, 'Pehuenches', 133, 0);
INSERT INTO `location` VALUES(1795, 'Picun Leufu', 133, 0);
INSERT INTO `location` VALUES(1796, 'Picunches', 133, 0);
INSERT INTO `location` VALUES(1797, 'Piedra del Aguila', 133, 0);
INSERT INTO `location` VALUES(1798, 'Plaza Huincul', 133, 0);
INSERT INTO `location` VALUES(1799, 'Plottier', 133, 0);
INSERT INTO `location` VALUES(1800, 'Rincón de los Sauces', 133, 0);
INSERT INTO `location` VALUES(1801, 'San Martin de los Andes', 133, 0);
INSERT INTO `location` VALUES(1802, 'San Patricio del Chañar', 133, 0);
INSERT INTO `location` VALUES(1803, 'Senillosa', 133, 0);
INSERT INTO `location` VALUES(1804, 'Villa El Chocón', 133, 0);
INSERT INTO `location` VALUES(1805, 'Villa la Angostura', 133, 0);
INSERT INTO `location` VALUES(1806, 'Villa Rincón Chico', 133, 0);
INSERT INTO `location` VALUES(1807, 'Vista Alegre Norte', 133, 0);
INSERT INTO `location` VALUES(1808, 'Vista Alegre Sur', 133, 0);
INSERT INTO `location` VALUES(1809, 'Zapala', 133, 0);
INSERT INTO `location` VALUES(1810, '25 De Mayo', 135, 0);
INSERT INTO `location` VALUES(1811, '9 De Julio', 135, 0);
INSERT INTO `location` VALUES(1812, 'Adolfo Alsina', 135, 0);
INSERT INTO `location` VALUES(1813, 'Allen', 135, 0);
INSERT INTO `location` VALUES(1814, 'Avellaneda', 135, 0);
INSERT INTO `location` VALUES(1815, 'Barda del Medio', 135, 0);
INSERT INTO `location` VALUES(1816, 'Bariloche', 135, 0);
INSERT INTO `location` VALUES(1817, 'C.cordero', 135, 0);
INSERT INTO `location` VALUES(1818, 'Catriel', 135, 0);
INSERT INTO `location` VALUES(1819, 'Cervantes', 135, 0);
INSERT INTO `location` VALUES(1820, 'Chichinales', 135, 0);
INSERT INTO `location` VALUES(1821, 'Chimpay', 135, 0);
INSERT INTO `location` VALUES(1822, 'Choele Choel', 135, 0);
INSERT INTO `location` VALUES(1823, 'Cinco Saltos', 135, 0);
INSERT INTO `location` VALUES(1824, 'Cipolletti', 135, 0);
INSERT INTO `location` VALUES(1825, 'Comallo', 135, 0);
INSERT INTO `location` VALUES(1826, 'Conesa', 135, 0);
INSERT INTO `location` VALUES(1827, 'Coronel Balisle', 135, 0);
INSERT INTO `location` VALUES(1828, 'Darwin', 135, 0);
INSERT INTO `location` VALUES(1829, 'Dina Huapi', 135, 0);
INSERT INTO `location` VALUES(1830, 'El Bolsón', 135, 0);
INSERT INTO `location` VALUES(1831, 'El Cuy', 135, 0);
INSERT INTO `location` VALUES(1832, 'Ferri', 135, 0);
INSERT INTO `location` VALUES(1833, 'Fray Luis Beltrán', 135, 0);
INSERT INTO `location` VALUES(1834, 'General Conesa', 135, 0);
INSERT INTO `location` VALUES(1835, 'General Enrique Godoy', 135, 0);
INSERT INTO `location` VALUES(1836, 'General Fernández Oro', 135, 0);
INSERT INTO `location` VALUES(1837, 'General Roca', 135, 0);
INSERT INTO `location` VALUES(1838, 'Ingeniero Jacobacci', 135, 0);
INSERT INTO `location` VALUES(1839, 'Ingeniero Luis A. Huergo', 135, 0);
INSERT INTO `location` VALUES(1840, 'Lamarque', 135, 0);
INSERT INTO `location` VALUES(1841, 'Las Grutas', 135, 0);
INSERT INTO `location` VALUES(1842, 'Los Menucos', 135, 0);
INSERT INTO `location` VALUES(1843, 'Mainqué', 135, 0);
INSERT INTO `location` VALUES(1844, 'Maquinchao', 135, 0);
INSERT INTO `location` VALUES(1845, 'Melipal', 135, 0);
INSERT INTO `location` VALUES(1846, 'Nahuel Malal', 135, 0);
INSERT INTO `location` VALUES(1847, 'Ñirihuau', 135, 0);
INSERT INTO `location` VALUES(1848, 'Ñorquinco', 135, 0);
INSERT INTO `location` VALUES(1849, 'Paso Córdoba', 135, 0);
INSERT INTO `location` VALUES(1850, 'Pichi Mahuida', 135, 0);
INSERT INTO `location` VALUES(1851, 'Pilnaniyeu', 135, 0);
INSERT INTO `location` VALUES(1852, 'Pinar del Lago', 135, 0);
INSERT INTO `location` VALUES(1853, 'Río Colorado', 135, 0);
INSERT INTO `location` VALUES(1854, 'San Antonio', 135, 0);
INSERT INTO `location` VALUES(1855, 'San Carlos de Bariloche', 135, 0);
INSERT INTO `location` VALUES(1856, 'Sierra Colorada', 135, 0);
INSERT INTO `location` VALUES(1857, 'Sierra Grande', 135, 0);
INSERT INTO `location` VALUES(1858, 'Valcheta', 135, 0);
INSERT INTO `location` VALUES(1859, 'Viedma', 135, 0);
INSERT INTO `location` VALUES(1860, 'Villa Alberdi', 135, 0);
INSERT INTO `location` VALUES(1861, 'Villa Llao Llao', 135, 0);
INSERT INTO `location` VALUES(1862, 'Villa Manzano', 135, 0);
INSERT INTO `location` VALUES(1863, 'Villa Regina', 135, 0);
INSERT INTO `location` VALUES(1864, 'Aguaray', 136, 0);
INSERT INTO `location` VALUES(1865, 'Aguas Blancas', 136, 0);
INSERT INTO `location` VALUES(1866, 'Animaná', 136, 0);
INSERT INTO `location` VALUES(1867, 'Anta', 136, 0);
INSERT INTO `location` VALUES(1868, 'Antilla', 136, 0);
INSERT INTO `location` VALUES(1869, 'Apolinario Saravia', 136, 0);
INSERT INTO `location` VALUES(1870, 'Cachi', 136, 0);
INSERT INTO `location` VALUES(1871, 'Cachi', 136, 0);
INSERT INTO `location` VALUES(1872, 'Cafayate', 136, 0);
INSERT INTO `location` VALUES(1873, 'Campamento Vespucio', 136, 0);
INSERT INTO `location` VALUES(1874, 'Campo Quijano', 136, 0);
INSERT INTO `location` VALUES(1875, 'Campo Santo', 136, 0);
INSERT INTO `location` VALUES(1876, 'Cerrillos', 136, 0);
INSERT INTO `location` VALUES(1877, 'Chicoana', 136, 0);
INSERT INTO `location` VALUES(1878, 'Cobos', 136, 0);
INSERT INTO `location` VALUES(1879, 'Coronel Cornejo', 136, 0);
INSERT INTO `location` VALUES(1880, 'Coronel Juan Solá', 136, 0);
INSERT INTO `location` VALUES(1881, 'Coronel Moldes', 136, 0);
INSERT INTO `location` VALUES(1882, 'Coronel Mollinedo', 136, 0);
INSERT INTO `location` VALUES(1883, 'Dragones', 136, 0);
INSERT INTO `location` VALUES(1884, 'El Bordo', 136, 0);
INSERT INTO `location` VALUES(1885, 'El Carril', 136, 0);
INSERT INTO `location` VALUES(1886, 'El Galpón', 136, 0);
INSERT INTO `location` VALUES(1887, 'El Jardín', 136, 0);
INSERT INTO `location` VALUES(1888, 'El Quebrachal', 136, 0);
INSERT INTO `location` VALUES(1889, 'El Tabacal', 136, 0);
INSERT INTO `location` VALUES(1890, 'El Tala', 136, 0);
INSERT INTO `location` VALUES(1891, 'Embarcación', 136, 0);
INSERT INTO `location` VALUES(1892, 'Gaona', 136, 0);
INSERT INTO `location` VALUES(1893, 'General Ballivián', 136, 0);
INSERT INTO `location` VALUES(1894, 'General Guemes', 136, 0);
INSERT INTO `location` VALUES(1895, 'General Mosconi', 136, 0);
INSERT INTO `location` VALUES(1896, 'General Pizarro', 136, 0);
INSERT INTO `location` VALUES(1897, 'General San Martin', 136, 0);
INSERT INTO `location` VALUES(1898, 'Guachipas', 136, 0);
INSERT INTO `location` VALUES(1899, 'Hipólito Yrigoyen', 136, 0);
INSERT INTO `location` VALUES(1900, 'Iruya', 136, 0);
INSERT INTO `location` VALUES(1901, 'Joaquín V. González', 136, 0);
INSERT INTO `location` VALUES(1902, 'La Caldera', 136, 0);
INSERT INTO `location` VALUES(1903, 'La Candelaria', 136, 0);
INSERT INTO `location` VALUES(1904, 'La Merced', 136, 0);
INSERT INTO `location` VALUES(1905, 'La Poma', 136, 0);
INSERT INTO `location` VALUES(1906, 'La Unión', 136, 0);
INSERT INTO `location` VALUES(1907, 'La Viña', 136, 0);
INSERT INTO `location` VALUES(1908, 'Las Lajitas', 136, 0);
INSERT INTO `location` VALUES(1909, 'Los Andes', 136, 0);
INSERT INTO `location` VALUES(1910, 'Los Blancos', 136, 0);
INSERT INTO `location` VALUES(1911, 'Mazza', 136, 0);
INSERT INTO `location` VALUES(1912, 'Metan', 136, 0);
INSERT INTO `location` VALUES(1913, 'Misión Chaqueña', 136, 0);
INSERT INTO `location` VALUES(1914, 'Molinos', 136, 0);
INSERT INTO `location` VALUES(1915, 'Ntra. Señora de Talavera', 136, 0);
INSERT INTO `location` VALUES(1916, 'Oran', 136, 0);
INSERT INTO `location` VALUES(1917, 'Pichanal', 136, 0);
INSERT INTO `location` VALUES(1918, 'Piquete Cabado', 136, 0);
INSERT INTO `location` VALUES(1919, 'Profesor Salvador', 136, 0);
INSERT INTO `location` VALUES(1920, 'Río del Valle', 136, 0);
INSERT INTO `location` VALUES(1921, 'Río Piedras', 136, 0);
INSERT INTO `location` VALUES(1922, 'Rivadavia', 136, 0);
INSERT INTO `location` VALUES(1923, 'Ros. de la Frontera', 136, 0);
INSERT INTO `location` VALUES(1924, 'Rosario de Lerma', 136, 0);
INSERT INTO `location` VALUES(1925, 'San Agustín', 136, 0);
INSERT INTO `location` VALUES(1926, 'San Antonio de los Cobres', 136, 0);
INSERT INTO `location` VALUES(1927, 'San Carlos', 136, 0);
INSERT INTO `location` VALUES(1928, 'San Lorenzo', 136, 0);
INSERT INTO `location` VALUES(1929, 'San Ramón de la Nueva Orán', 136, 0);
INSERT INTO `location` VALUES(1930, 'Santa Rosa', 136, 0);
INSERT INTO `location` VALUES(1931, 'Santa Victoria', 136, 0);
INSERT INTO `location` VALUES(1932, 'Tartagal', 136, 0);
INSERT INTO `location` VALUES(1933, 'Urundel', 136, 0);
INSERT INTO `location` VALUES(1934, 'Yacuy', 136, 0);
INSERT INTO `location` VALUES(1935, '25 de Mayo', 137, 0);
INSERT INTO `location` VALUES(1936, '9 de julio', 137, 0);
INSERT INTO `location` VALUES(1937, 'Albardon', 137, 0);
INSERT INTO `location` VALUES(1938, 'Angaco', 137, 0);
INSERT INTO `location` VALUES(1939, 'Barreal', 137, 0);
INSERT INTO `location` VALUES(1940, 'Berazategui', 137, 0);
INSERT INTO `location` VALUES(1941, 'Calingasta', 137, 0);
INSERT INTO `location` VALUES(1942, 'Caucete', 137, 0);
INSERT INTO `location` VALUES(1943, 'Chimbas', 137, 0);
INSERT INTO `location` VALUES(1944, 'Difunta Correa', 137, 0);
INSERT INTO `location` VALUES(1945, 'El Encón', 137, 0);
INSERT INTO `location` VALUES(1946, 'Huaco', 137, 0);
INSERT INTO `location` VALUES(1947, 'Iglesia', 137, 0);
INSERT INTO `location` VALUES(1948, 'Jachal', 137, 0);
INSERT INTO `location` VALUES(1949, 'La Rinconada', 137, 0);
INSERT INTO `location` VALUES(1950, 'Las Flores', 137, 0);
INSERT INTO `location` VALUES(1951, 'Niquivil', 137, 0);
INSERT INTO `location` VALUES(1952, 'Pampa Vieja', 137, 0);
INSERT INTO `location` VALUES(1953, 'Pocito', 137, 0);
INSERT INTO `location` VALUES(1954, 'Rawson', 137, 0);
INSERT INTO `location` VALUES(1955, 'Rivadavia', 137, 0);
INSERT INTO `location` VALUES(1956, 'Rodeo', 137, 0);
INSERT INTO `location` VALUES(1957, 'San Isidro', 137, 0);
INSERT INTO `location` VALUES(1958, 'San José de Jáchal', 137, 0);
INSERT INTO `location` VALUES(1959, 'San Juan', 137, 0);
INSERT INTO `location` VALUES(1960, 'San Martin', 137, 0);
INSERT INTO `location` VALUES(1961, 'Santa Lucia', 137, 0);
INSERT INTO `location` VALUES(1962, 'Sarmiento', 137, 0);
INSERT INTO `location` VALUES(1963, 'Tamberías', 137, 0);
INSERT INTO `location` VALUES(1964, 'Tudcum', 137, 0);
INSERT INTO `location` VALUES(1965, 'Ullum', 137, 0);
INSERT INTO `location` VALUES(1966, 'Valle Fertil', 137, 0);
INSERT INTO `location` VALUES(1967, 'Villa Aberastain', 137, 0);
INSERT INTO `location` VALUES(1968, 'Villa Basilio Nievas', 137, 0);
INSERT INTO `location` VALUES(1969, 'Villa Del Salvador', 137, 0);
INSERT INTO `location` VALUES(1970, 'Villa Don Bosco', 137, 0);
INSERT INTO `location` VALUES(1971, 'Villa Gral. San Martín', 137, 0);
INSERT INTO `location` VALUES(1972, 'Villa Ibáñez', 137, 0);
INSERT INTO `location` VALUES(1973, 'Villa Krause', 137, 0);
INSERT INTO `location` VALUES(1974, 'Villa Media Agua', 137, 0);
INSERT INTO `location` VALUES(1975, 'Villa Mercedes', 137, 0);
INSERT INTO `location` VALUES(1976, 'Villa San Agustín del Valle Fértil', 137, 0);
INSERT INTO `location` VALUES(1977, 'Villa Santa Rosa', 137, 0);
INSERT INTO `location` VALUES(1978, 'Zonda', 137, 0);
INSERT INTO `location` VALUES(1979, 'Ayacucho', 138, 0);
INSERT INTO `location` VALUES(1980, 'Beazley', 138, 0);
INSERT INTO `location` VALUES(1981, 'Belgrano', 138, 0);
INSERT INTO `location` VALUES(1982, 'Buena Esperanza', 138, 0);
INSERT INTO `location` VALUES(1983, 'Candelaria', 138, 0);
INSERT INTO `location` VALUES(1984, 'Chacabuco', 138, 0);
INSERT INTO `location` VALUES(1985, 'Concarán', 138, 0);
INSERT INTO `location` VALUES(1986, 'Coronel Pringles', 138, 0);
INSERT INTO `location` VALUES(1987, 'Fortuna', 138, 0);
INSERT INTO `location` VALUES(1988, 'Fraga', 138, 0);
INSERT INTO `location` VALUES(1989, 'General Pedernera', 138, 0);
INSERT INTO `location` VALUES(1990, 'Gobernador Dupuy', 138, 0);
INSERT INTO `location` VALUES(1991, 'Junin', 138, 0);
INSERT INTO `location` VALUES(1992, 'Justo Daract', 138, 0);
INSERT INTO `location` VALUES(1993, 'La Calera', 138, 0);
INSERT INTO `location` VALUES(1994, 'La Toma', 138, 0);
INSERT INTO `location` VALUES(1995, 'Las Isletas', 138, 0);
INSERT INTO `location` VALUES(1996, 'Ldor Gral San Martin', 138, 0);
INSERT INTO `location` VALUES(1997, 'Luján', 138, 0);
INSERT INTO `location` VALUES(1998, 'Mercedes', 138, 0);
INSERT INTO `location` VALUES(1999, 'Merlo', 138, 0);
INSERT INTO `location` VALUES(2000, 'Quines', 138, 0);
INSERT INTO `location` VALUES(2001, 'San Francisco del Monte de Oro', 138, 0);
INSERT INTO `location` VALUES(2002, 'San Luis', 138, 0);
INSERT INTO `location` VALUES(2003, 'Santa Rosa del Conlara', 138, 0);
INSERT INTO `location` VALUES(2004, 'Tilisarao', 138, 0);
INSERT INTO `location` VALUES(2005, 'Trapiche', 138, 0);
INSERT INTO `location` VALUES(2006, 'Unión', 138, 0);
INSERT INTO `location` VALUES(2007, 'Villa General Roca', 138, 0);
INSERT INTO `location` VALUES(2008, 'Villa Mercedes', 138, 0);
INSERT INTO `location` VALUES(2009, 'Villa Reynolds', 138, 0);
INSERT INTO `location` VALUES(2010, '28 de Noviembre', 139, 0);
INSERT INTO `location` VALUES(2011, 'Caleta Olivia', 139, 0);
INSERT INTO `location` VALUES(2012, 'Cañadon Seco', 139, 0);
INSERT INTO `location` VALUES(2013, 'Comandante Luis Peidrabuena', 139, 0);
INSERT INTO `location` VALUES(2014, 'Corpen Aike', 139, 0);
INSERT INTO `location` VALUES(2015, 'Deseado', 139, 0);
INSERT INTO `location` VALUES(2016, 'El Calafate', 139, 0);
INSERT INTO `location` VALUES(2017, 'Gobernador Gregores', 139, 0);
INSERT INTO `location` VALUES(2018, 'Guer Aike', 139, 0);
INSERT INTO `location` VALUES(2019, 'Lago Argentino', 139, 0);
INSERT INTO `location` VALUES(2020, 'Lago Buenos Aires', 139, 0);
INSERT INTO `location` VALUES(2021, 'Las Heras', 139, 0);
INSERT INTO `location` VALUES(2022, 'Los Antiguos', 139, 0);
INSERT INTO `location` VALUES(2023, 'Magallanes', 139, 0);
INSERT INTO `location` VALUES(2024, 'Mina 3', 139, 0);
INSERT INTO `location` VALUES(2025, 'Perito Moreno', 139, 0);
INSERT INTO `location` VALUES(2026, 'Pico Truncado', 139, 0);
INSERT INTO `location` VALUES(2027, 'Puerto Deseado', 139, 0);
INSERT INTO `location` VALUES(2028, 'Puerto San Julian', 139, 0);
INSERT INTO `location` VALUES(2029, 'Puerto Santa Cruz', 139, 0);
INSERT INTO `location` VALUES(2030, 'Rio Chico', 139, 0);
INSERT INTO `location` VALUES(2031, 'Rio Gallegos', 139, 0);
INSERT INTO `location` VALUES(2032, 'Rospentek Aike', 139, 0);
INSERT INTO `location` VALUES(2033, 'Yacimientos Río Turbio', 139, 0);
INSERT INTO `location` VALUES(2034, '9 De Julio', 140, 0);
INSERT INTO `location` VALUES(2035, 'Acebal', 140, 0);
INSERT INTO `location` VALUES(2036, 'Alcorta', 140, 0);
INSERT INTO `location` VALUES(2037, 'Aldao', 140, 0);
INSERT INTO `location` VALUES(2038, 'Alejandra', 140, 0);
INSERT INTO `location` VALUES(2039, 'Alvarez', 140, 0);
INSERT INTO `location` VALUES(2040, 'Alvear', 140, 0);
INSERT INTO `location` VALUES(2041, 'Ambrosetti', 140, 0);
INSERT INTO `location` VALUES(2042, 'Amenábar', 140, 0);
INSERT INTO `location` VALUES(2043, 'Angélica', 140, 0);
INSERT INTO `location` VALUES(2044, 'Arequito', 140, 0);
INSERT INTO `location` VALUES(2045, 'Armstrong', 140, 0);
INSERT INTO `location` VALUES(2046, 'Arocena', 140, 0);
INSERT INTO `location` VALUES(2047, 'Arroyo Aguilar', 140, 0);
INSERT INTO `location` VALUES(2048, 'Arroyo Seco', 140, 0);
INSERT INTO `location` VALUES(2049, 'Arrufo', 140, 0);
INSERT INTO `location` VALUES(2050, 'Arteaga', 140, 0);
INSERT INTO `location` VALUES(2051, 'Ataliva', 140, 0);
INSERT INTO `location` VALUES(2052, 'Avellaneda', 140, 0);
INSERT INTO `location` VALUES(2053, 'Barrancas', 140, 0);
INSERT INTO `location` VALUES(2054, 'Belgrano', 140, 0);
INSERT INTO `location` VALUES(2055, 'Berabevú', 140, 0);
INSERT INTO `location` VALUES(2056, 'Berna', 140, 0);
INSERT INTO `location` VALUES(2057, 'Bernardo de Irigoyen', 140, 0);
INSERT INTO `location` VALUES(2058, 'Bigand', 140, 0);
INSERT INTO `location` VALUES(2059, 'Bombal', 140, 0);
INSERT INTO `location` VALUES(2060, 'Bouquet', 140, 0);
INSERT INTO `location` VALUES(2061, 'Bustinza', 140, 0);
INSERT INTO `location` VALUES(2062, 'Cafferata', 140, 0);
INSERT INTO `location` VALUES(2063, 'Calchaquí', 140, 0);
INSERT INTO `location` VALUES(2064, 'Can Cristóbal', 140, 0);
INSERT INTO `location` VALUES(2065, 'Cañada de Gomez', 140, 0);
INSERT INTO `location` VALUES(2066, 'Cañada Del Ucle', 140, 0);
INSERT INTO `location` VALUES(2067, 'Cañada Rica', 140, 0);
INSERT INTO `location` VALUES(2068, 'Cañada Rosquín', 140, 0);
INSERT INTO `location` VALUES(2069, 'Capitán Bermúdez', 140, 0);
INSERT INTO `location` VALUES(2070, 'Carcarañá', 140, 0);
INSERT INTO `location` VALUES(2071, 'Carlos Pellegrini', 140, 0);
INSERT INTO `location` VALUES(2072, 'Carmen', 140, 0);
INSERT INTO `location` VALUES(2073, 'Carreras', 140, 0);
INSERT INTO `location` VALUES(2074, 'Carrizales', 140, 0);
INSERT INTO `location` VALUES(2075, 'Casas', 140, 0);
INSERT INTO `location` VALUES(2076, 'Caseros', 140, 0);
INSERT INTO `location` VALUES(2077, 'Casilda', 140, 0);
INSERT INTO `location` VALUES(2078, 'Castellanos', 140, 0);
INSERT INTO `location` VALUES(2079, 'Cayastá', 140, 0);
INSERT INTO `location` VALUES(2080, 'Centeno', 140, 0);
INSERT INTO `location` VALUES(2081, 'Cepeda', 140, 0);
INSERT INTO `location` VALUES(2082, 'Ceres', 140, 0);
INSERT INTO `location` VALUES(2083, 'Chabás', 140, 0);
INSERT INTO `location` VALUES(2084, 'Chañar Ladeado', 140, 0);
INSERT INTO `location` VALUES(2085, 'Charas', 140, 0);
INSERT INTO `location` VALUES(2086, 'Chovet', 140, 0);
INSERT INTO `location` VALUES(2087, 'Clucellas', 140, 0);
INSERT INTO `location` VALUES(2088, 'Colonia Belgrano', 140, 0);
INSERT INTO `location` VALUES(2089, 'Colonia Margarita', 140, 0);
INSERT INTO `location` VALUES(2090, 'Constitucion', 140, 0);
INSERT INTO `location` VALUES(2091, 'Coronda', 140, 0);
INSERT INTO `location` VALUES(2092, 'Coronel Arnold', 140, 0);
INSERT INTO `location` VALUES(2093, 'Coronel Bogado', 140, 0);
INSERT INTO `location` VALUES(2094, 'Coronel Rodolfo S. Dominguez', 140, 0);
INSERT INTO `location` VALUES(2095, 'Correa', 140, 0);
INSERT INTO `location` VALUES(2096, 'Cptan. Bermúdez', 140, 0);
INSERT INTO `location` VALUES(2097, 'Desvío Arijón', 140, 0);
INSERT INTO `location` VALUES(2098, 'Díaz', 140, 0);
INSERT INTO `location` VALUES(2099, 'Diego de Alvear', 140, 0);
INSERT INTO `location` VALUES(2100, 'El Trébol', 140, 0);
INSERT INTO `location` VALUES(2101, 'Elisa', 140, 0);
INSERT INTO `location` VALUES(2102, 'Elortondo', 140, 0);
INSERT INTO `location` VALUES(2103, 'Empalme Villa Constitución', 140, 0);
INSERT INTO `location` VALUES(2104, 'Esmeralda', 140, 0);
INSERT INTO `location` VALUES(2105, 'Esperanza', 140, 0);
INSERT INTO `location` VALUES(2106, 'Esther', 140, 0);
INSERT INTO `location` VALUES(2107, 'Eusebia', 140, 0);
INSERT INTO `location` VALUES(2108, 'Felicia', 140, 0);
INSERT INTO `location` VALUES(2109, 'Fighiera', 140, 0);
INSERT INTO `location` VALUES(2110, 'Firmat', 140, 0);
INSERT INTO `location` VALUES(2111, 'Florencia', 140, 0);
INSERT INTO `location` VALUES(2112, 'Fortín Olmos', 140, 0);
INSERT INTO `location` VALUES(2113, 'Franck', 140, 0);
INSERT INTO `location` VALUES(2114, 'Fray Luis Beltrán', 140, 0);
INSERT INTO `location` VALUES(2115, 'Frontera', 140, 0);
INSERT INTO `location` VALUES(2116, 'Fuentes', 140, 0);
INSERT INTO `location` VALUES(2117, 'Funes', 140, 0);
INSERT INTO `location` VALUES(2118, 'Gaboto', 140, 0);
INSERT INTO `location` VALUES(2119, 'Gálvez', 140, 0);
INSERT INTO `location` VALUES(2120, 'Garaboto', 140, 0);
INSERT INTO `location` VALUES(2121, 'Garay', 140, 0);
INSERT INTO `location` VALUES(2122, 'Gato Colorado', 140, 0);
INSERT INTO `location` VALUES(2123, 'Gdero. Baigorria', 140, 0);
INSERT INTO `location` VALUES(2124, 'General Gelly', 140, 0);
INSERT INTO `location` VALUES(2125, 'General Lagos', 140, 0);
INSERT INTO `location` VALUES(2126, 'General Lopez', 140, 0);
INSERT INTO `location` VALUES(2127, 'General Obligado', 140, 0);
INSERT INTO `location` VALUES(2128, 'Gessler', 140, 0);
INSERT INTO `location` VALUES(2129, 'Gobernador Candioti', 140, 0);
INSERT INTO `location` VALUES(2130, 'Gobernador Crespo', 140, 0);
INSERT INTO `location` VALUES(2131, 'Gobernador Gálvez', 140, 0);
INSERT INTO `location` VALUES(2132, 'Gödeken', 140, 0);
INSERT INTO `location` VALUES(2133, 'Godoy', 140, 0);
INSERT INTO `location` VALUES(2134, 'Granadero Baigorria', 140, 0);
INSERT INTO `location` VALUES(2135, 'Gregoria Pérez de Denis', 140, 0);
INSERT INTO `location` VALUES(2136, 'Grutly', 140, 0);
INSERT INTO `location` VALUES(2137, 'Helvecia', 140, 0);
INSERT INTO `location` VALUES(2138, 'Hersilia', 140, 0);
INSERT INTO `location` VALUES(2139, 'Huanqueros', 140, 0);
INSERT INTO `location` VALUES(2140, 'Hughes', 140, 0);
INSERT INTO `location` VALUES(2141, 'Humberto I', 140, 0);
INSERT INTO `location` VALUES(2142, 'Humboldt', 140, 0);
INSERT INTO `location` VALUES(2143, 'Ibarlucea', 140, 0);
INSERT INTO `location` VALUES(2144, 'Intiyaco', 140, 0);
INSERT INTO `location` VALUES(2145, 'Irigoyen', 140, 0);
INSERT INTO `location` VALUES(2146, 'Iriondo', 140, 0);
INSERT INTO `location` VALUES(2147, 'Josefina', 140, 0);
INSERT INTO `location` VALUES(2148, 'Juan B. Molina', 140, 0);
INSERT INTO `location` VALUES(2149, 'Juncal', 140, 0);
INSERT INTO `location` VALUES(2150, 'La Criolla', 140, 0);
INSERT INTO `location` VALUES(2151, 'La Gallareta', 140, 0);
INSERT INTO `location` VALUES(2152, 'La Pelada', 140, 0);
INSERT INTO `location` VALUES(2153, 'Labordeboy', 140, 0);
INSERT INTO `location` VALUES(2154, 'Laguna Paiva', 140, 0);
INSERT INTO `location` VALUES(2155, 'Landeta', 140, 0);
INSERT INTO `location` VALUES(2156, 'Lanteri', 140, 0);
INSERT INTO `location` VALUES(2157, 'Las Colonias', 140, 0);
INSERT INTO `location` VALUES(2158, 'Las Garzas', 140, 0);
INSERT INTO `location` VALUES(2159, 'Las Palmeras', 140, 0);
INSERT INTO `location` VALUES(2160, 'Las Parejas', 140, 0);
INSERT INTO `location` VALUES(2161, 'Las Petacas', 140, 0);
INSERT INTO `location` VALUES(2162, 'Las Rosas', 140, 0);
INSERT INTO `location` VALUES(2163, 'Las Toscas', 140, 0);
INSERT INTO `location` VALUES(2164, 'Lehmann', 140, 0);
INSERT INTO `location` VALUES(2165, 'Llambi Campbell', 140, 0);
INSERT INTO `location` VALUES(2166, 'López', 140, 0);
INSERT INTO `location` VALUES(2167, 'Los Amores', 140, 0);
INSERT INTO `location` VALUES(2168, 'Los Cardos', 140, 0);
INSERT INTO `location` VALUES(2169, 'Los Molinos', 140, 0);
INSERT INTO `location` VALUES(2170, 'Los Quirquinchos', 140, 0);
INSERT INTO `location` VALUES(2171, 'Maciel ', 140, 0);
INSERT INTO `location` VALUES(2172, 'Maggiolo', 140, 0);
INSERT INTO `location` VALUES(2173, 'Malabrigo', 140, 0);
INSERT INTO `location` VALUES(2174, 'Marcelino Escalada', 140, 0);
INSERT INTO `location` VALUES(2175, 'Margarita', 140, 0);
INSERT INTO `location` VALUES(2176, 'María Juana', 140, 0);
INSERT INTO `location` VALUES(2177, 'María Teresa', 140, 0);
INSERT INTO `location` VALUES(2178, 'Matilde', 140, 0);
INSERT INTO `location` VALUES(2179, 'Máximo Paz', 140, 0);
INSERT INTO `location` VALUES(2180, 'Melincué', 140, 0);
INSERT INTO `location` VALUES(2181, 'Moisés Ville', 140, 0);
INSERT INTO `location` VALUES(2182, 'Monje', 140, 0);
INSERT INTO `location` VALUES(2183, 'Monte Vera', 140, 0);
INSERT INTO `location` VALUES(2184, 'Montes de Oca', 140, 0);
INSERT INTO `location` VALUES(2185, 'Murphy', 140, 0);
INSERT INTO `location` VALUES(2186, 'Nelson', 140, 0);
INSERT INTO `location` VALUES(2187, 'Oliveros', 140, 0);
INSERT INTO `location` VALUES(2188, 'Palacios', 140, 0);
INSERT INTO `location` VALUES(2189, 'Pavón', 140, 0);
INSERT INTO `location` VALUES(2190, 'Pavón Arriba', 140, 0);
INSERT INTO `location` VALUES(2191, 'Pedro Gomez Cello', 140, 0);
INSERT INTO `location` VALUES(2192, 'Pérez', 140, 0);
INSERT INTO `location` VALUES(2193, 'Peyrano', 140, 0);
INSERT INTO `location` VALUES(2194, 'Piamonte', 140, 0);
INSERT INTO `location` VALUES(2195, 'Pilar', 140, 0);
INSERT INTO `location` VALUES(2196, 'Piñero', 140, 0);
INSERT INTO `location` VALUES(2197, 'Plaza Clucellas', 140, 0);
INSERT INTO `location` VALUES(2198, 'Pozo Borrado', 140, 0);
INSERT INTO `location` VALUES(2199, 'Progreso', 140, 0);
INSERT INTO `location` VALUES(2200, 'Providencia', 140, 0);
INSERT INTO `location` VALUES(2201, 'Pueblo Andino', 140, 0);
INSERT INTO `location` VALUES(2202, 'Pueblo Muñoz', 140, 0);
INSERT INTO `location` VALUES(2203, 'Pujato', 140, 0);
INSERT INTO `location` VALUES(2204, 'Reconquista', 140, 0);
INSERT INTO `location` VALUES(2205, 'Recreo', 140, 0);
INSERT INTO `location` VALUES(2206, 'Ricardone', 140, 0);
INSERT INTO `location` VALUES(2207, 'Roldán', 140, 0);
INSERT INTO `location` VALUES(2208, 'Romang', 140, 0);
INSERT INTO `location` VALUES(2209, 'Rufino', 140, 0);
INSERT INTO `location` VALUES(2210, 'Sa. Pereyra', 140, 0);
INSERT INTO `location` VALUES(2211, 'Salto Grande', 140, 0);
INSERT INTO `location` VALUES(2212, 'San Antonio de Obligado', 140, 0);
INSERT INTO `location` VALUES(2213, 'San Carlos Centro', 140, 0);
INSERT INTO `location` VALUES(2214, 'San Carlos Norte', 140, 0);
INSERT INTO `location` VALUES(2215, 'San Carlos Sur', 140, 0);
INSERT INTO `location` VALUES(2216, 'San Cristobal', 140, 0);
INSERT INTO `location` VALUES(2217, 'San Eduardo', 140, 0);
INSERT INTO `location` VALUES(2218, 'San Fabián', 140, 0);
INSERT INTO `location` VALUES(2219, 'San Genaro', 140, 0);
INSERT INTO `location` VALUES(2220, 'San Genaro Norte', 140, 0);
INSERT INTO `location` VALUES(2221, 'San Gregorio', 140, 0);
INSERT INTO `location` VALUES(2222, 'San Javier', 140, 0);
INSERT INTO `location` VALUES(2223, 'San Jeronimo', 140, 0);
INSERT INTO `location` VALUES(2224, 'San Jerónimo Norte', 140, 0);
INSERT INTO `location` VALUES(2225, 'San Jerónimo Sur', 140, 0);
INSERT INTO `location` VALUES(2226, 'San Jorge', 140, 0);
INSERT INTO `location` VALUES(2227, 'San José de la Esquina', 140, 0);
INSERT INTO `location` VALUES(2228, 'San Justo', 140, 0);
INSERT INTO `location` VALUES(2229, 'San Lorenzo', 140, 0);
INSERT INTO `location` VALUES(2230, 'San Martin', 140, 0);
INSERT INTO `location` VALUES(2231, 'San Vicente', 140, 0);
INSERT INTO `location` VALUES(2232, 'Sancti Spíritu', 140, 0);
INSERT INTO `location` VALUES(2233, 'Sanford', 140, 0);
INSERT INTO `location` VALUES(2234, 'Santa Clara de Buena Vista', 140, 0);
INSERT INTO `location` VALUES(2235, 'Santa Clara de Saguier', 140, 0);
INSERT INTO `location` VALUES(2236, 'Santa Isabel', 140, 0);
INSERT INTO `location` VALUES(2237, 'Santa Margarita', 140, 0);
INSERT INTO `location` VALUES(2238, 'Santa Rosa de Calchines', 140, 0);
INSERT INTO `location` VALUES(2239, 'Santa Teresa', 140, 0);
INSERT INTO `location` VALUES(2240, 'Santo Domingo', 140, 0);
INSERT INTO `location` VALUES(2241, 'Santo Tome', 140, 0);
INSERT INTO `location` VALUES(2242, 'Sargento Cabral', 140, 0);
INSERT INTO `location` VALUES(2243, 'Sarmiento', 140, 0);
INSERT INTO `location` VALUES(2244, 'Sastre', 140, 0);
INSERT INTO `location` VALUES(2245, 'Sauce Viejo', 140, 0);
INSERT INTO `location` VALUES(2246, 'Serodino', 140, 0);
INSERT INTO `location` VALUES(2247, 'Soldini', 140, 0);
INSERT INTO `location` VALUES(2248, 'Soledad', 140, 0);
INSERT INTO `location` VALUES(2249, 'Sunchales', 140, 0);
INSERT INTO `location` VALUES(2250, 'Susana', 140, 0);
INSERT INTO `location` VALUES(2251, 'Tacuarendí', 140, 0);
INSERT INTO `location` VALUES(2252, 'Tacural', 140, 0);
INSERT INTO `location` VALUES(2253, 'Tartagal', 140, 0);
INSERT INTO `location` VALUES(2254, 'Teodelina', 140, 0);
INSERT INTO `location` VALUES(2255, 'Theobald', 140, 0);
INSERT INTO `location` VALUES(2256, 'Timbúes', 140, 0);
INSERT INTO `location` VALUES(2257, 'Tortugas', 140, 0);
INSERT INTO `location` VALUES(2258, 'Tostado', 140, 0);
INSERT INTO `location` VALUES(2259, 'Totoras', 140, 0);
INSERT INTO `location` VALUES(2260, 'Uranga', 140, 0);
INSERT INTO `location` VALUES(2261, 'Vera', 140, 0);
INSERT INTO `location` VALUES(2262, 'Vera y Pintado', 140, 0);
INSERT INTO `location` VALUES(2263, 'Videla', 140, 0);
INSERT INTO `location` VALUES(2264, 'Vila', 140, 0);
INSERT INTO `location` VALUES(2265, 'Villa Ana', 140, 0);
INSERT INTO `location` VALUES(2266, 'Villa Cañás', 140, 0);
INSERT INTO `location` VALUES(2267, 'Villa Constitución', 140, 0);
INSERT INTO `location` VALUES(2268, 'Villa Eloísa', 140, 0);
INSERT INTO `location` VALUES(2269, 'Villa Gdor. Gálvez', 140, 0);
INSERT INTO `location` VALUES(2270, 'Villa Guillermina', 140, 0);
INSERT INTO `location` VALUES(2271, 'Villa Minetti', 140, 0);
INSERT INTO `location` VALUES(2272, 'Villa Mugueta', 140, 0);
INSERT INTO `location` VALUES(2273, 'Villa Ocampo', 140, 0);
INSERT INTO `location` VALUES(2274, 'Villa Trinidad', 140, 0);
INSERT INTO `location` VALUES(2275, 'Villada', 140, 0);
INSERT INTO `location` VALUES(2276, 'Wheelwright', 140, 0);
INSERT INTO `location` VALUES(2277, 'Zavalla', 140, 0);
INSERT INTO `location` VALUES(2278, 'Zenón Pereyra', 140, 0);
INSERT INTO `location` VALUES(2279, 'Aguirre', 141, 0);
INSERT INTO `location` VALUES(2280, 'Alberdi', 141, 0);
INSERT INTO `location` VALUES(2281, 'Añatuya', 141, 0);
INSERT INTO `location` VALUES(2282, 'Arraga', 141, 0);
INSERT INTO `location` VALUES(2283, 'Atamisqui', 141, 0);
INSERT INTO `location` VALUES(2284, 'Avellaneda', 141, 0);
INSERT INTO `location` VALUES(2285, 'Badera Bajada', 141, 0);
INSERT INTO `location` VALUES(2286, 'Banda', 141, 0);
INSERT INTO `location` VALUES(2287, 'Bandera', 141, 0);
INSERT INTO `location` VALUES(2288, 'Belgrano', 141, 0);
INSERT INTO `location` VALUES(2289, 'Brea Pozo', 141, 0);
INSERT INTO `location` VALUES(2290, 'Campo Gallo', 141, 0);
INSERT INTO `location` VALUES(2291, 'Choya', 141, 0);
INSERT INTO `location` VALUES(2292, 'Ciudad de Loreto', 141, 0);
INSERT INTO `location` VALUES(2293, 'Clodomira', 141, 0);
INSERT INTO `location` VALUES(2294, 'Colonia Dora', 141, 0);
INSERT INTO `location` VALUES(2295, 'Colonia El Simbolar', 141, 0);
INSERT INTO `location` VALUES(2296, 'Copo', 141, 0);
INSERT INTO `location` VALUES(2297, 'El Caburá', 141, 0);
INSERT INTO `location` VALUES(2298, 'El Charco', 141, 0);
INSERT INTO `location` VALUES(2299, 'El Mojón', 141, 0);
INSERT INTO `location` VALUES(2300, 'Fernández', 141, 0);
INSERT INTO `location` VALUES(2301, 'Figueroa', 141, 0);
INSERT INTO `location` VALUES(2302, 'Frías', 141, 0);
INSERT INTO `location` VALUES(2303, 'Garza', 141, 0);
INSERT INTO `location` VALUES(2304, 'General Taboada', 141, 0);
INSERT INTO `location` VALUES(2305, 'Guardia Escolta', 141, 0);
INSERT INTO `location` VALUES(2306, 'Guasayan', 141, 0);
INSERT INTO `location` VALUES(2307, 'Herrera', 141, 0);
INSERT INTO `location` VALUES(2308, 'Icaño', 141, 0);
INSERT INTO `location` VALUES(2309, 'Jimenez', 141, 0);
INSERT INTO `location` VALUES(2310, 'Juan F. Ibarra', 141, 0);
INSERT INTO `location` VALUES(2311, 'La Aurora', 141, 0);
INSERT INTO `location` VALUES(2312, 'La Banda', 141, 0);
INSERT INTO `location` VALUES(2313, 'La Cañada', 141, 0);
INSERT INTO `location` VALUES(2314, 'La Fragua', 141, 0);
INSERT INTO `location` VALUES(2315, 'Laprida', 141, 0);
INSERT INTO `location` VALUES(2316, 'Lavalle', 141, 0);
INSERT INTO `location` VALUES(2317, 'Loreto', 141, 0);
INSERT INTO `location` VALUES(2318, 'Los Juríes', 141, 0);
INSERT INTO `location` VALUES(2319, 'Los Nuñez', 141, 0);
INSERT INTO `location` VALUES(2320, 'Los Pirpintos', 141, 0);
INSERT INTO `location` VALUES(2321, 'Los Quiroga', 141, 0);
INSERT INTO `location` VALUES(2322, 'Los Telares', 141, 0);
INSERT INTO `location` VALUES(2323, 'Lugones', 141, 0);
INSERT INTO `location` VALUES(2324, 'Malbrán', 141, 0);
INSERT INTO `location` VALUES(2325, 'Matará', 141, 0);
INSERT INTO `location` VALUES(2326, 'Mitre', 141, 0);
INSERT INTO `location` VALUES(2327, 'Monte Quemado', 141, 0);
INSERT INTO `location` VALUES(2328, 'Moreno', 141, 0);
INSERT INTO `location` VALUES(2329, 'Nueva Esperanza', 141, 0);
INSERT INTO `location` VALUES(2330, 'Nueva Francia', 141, 0);
INSERT INTO `location` VALUES(2331, 'Ojo de agua', 141, 0);
INSERT INTO `location` VALUES(2332, 'Pampa de los Guanacos', 141, 0);
INSERT INTO `location` VALUES(2333, 'Pelegrini', 141, 0);
INSERT INTO `location` VALUES(2334, 'Pinto', 141, 0);
INSERT INTO `location` VALUES(2335, 'Pozo Hondo', 141, 0);
INSERT INTO `location` VALUES(2336, 'Quebrachos', 141, 0);
INSERT INTO `location` VALUES(2337, 'Quimilí', 141, 0);
INSERT INTO `location` VALUES(2338, 'Rapelli', 141, 0);
INSERT INTO `location` VALUES(2339, 'Real Sayana', 141, 0);
INSERT INTO `location` VALUES(2340, 'Rio Hondo', 141, 0);
INSERT INTO `location` VALUES(2341, 'Rivadavia', 141, 0);
INSERT INTO `location` VALUES(2342, 'Robles', 141, 0);
INSERT INTO `location` VALUES(2343, 'Sachayoj', 141, 0);
INSERT INTO `location` VALUES(2344, 'Salavina', 141, 0);
INSERT INTO `location` VALUES(2345, 'San Martin', 141, 0);
INSERT INTO `location` VALUES(2346, 'San Pedro', 141, 0);
INSERT INTO `location` VALUES(2347, 'Santiago del Estero', 141, 0);
INSERT INTO `location` VALUES(2348, 'Sarmiento', 141, 0);
INSERT INTO `location` VALUES(2349, 'Selva', 141, 0);
INSERT INTO `location` VALUES(2350, 'Silipica', 141, 0);
INSERT INTO `location` VALUES(2351, 'Simbolar', 141, 0);
INSERT INTO `location` VALUES(2352, 'Sol de Julio', 141, 0);
INSERT INTO `location` VALUES(2353, 'Sumampa', 141, 0);
INSERT INTO `location` VALUES(2354, 'Suncho Corral', 141, 0);
INSERT INTO `location` VALUES(2355, 'Tapso', 141, 0);
INSERT INTO `location` VALUES(2356, 'Termas de Río Hondo', 141, 0);
INSERT INTO `location` VALUES(2357, 'Tintina', 141, 0);
INSERT INTO `location` VALUES(2358, 'Vilelas', 141, 0);
INSERT INTO `location` VALUES(2359, 'Villa Atamisqui', 141, 0);
INSERT INTO `location` VALUES(2360, 'Villa La Punta', 141, 0);
INSERT INTO `location` VALUES(2361, 'Villa Ojo de Agua', 141, 0);
INSERT INTO `location` VALUES(2362, 'Villa Río Hondo', 141, 0);
INSERT INTO `location` VALUES(2363, 'Lapataia', 142, 0);
INSERT INTO `location` VALUES(2364, 'San Sebastián', 142, 0);
INSERT INTO `location` VALUES(2365, 'Tolhuin', 142, 0);
INSERT INTO `location` VALUES(2366, 'Ushuaia', 142, 0);
INSERT INTO `location` VALUES(2367, 'Acheral', 143, 0);
INSERT INTO `location` VALUES(2368, 'Aguilares', 143, 0);
INSERT INTO `location` VALUES(2369, 'Alderetes', 143, 0);
INSERT INTO `location` VALUES(2370, 'Alpachiri', 143, 0);
INSERT INTO `location` VALUES(2371, 'Alto Verde', 143, 0);
INSERT INTO `location` VALUES(2372, 'Amaichá del Valle', 143, 0);
INSERT INTO `location` VALUES(2373, 'Aráoz', 143, 0);
INSERT INTO `location` VALUES(2374, 'Arcadia', 143, 0);
INSERT INTO `location` VALUES(2375, 'Banda del Río Salí', 143, 0);
INSERT INTO `location` VALUES(2376, 'Bella Vista', 143, 0);
INSERT INTO `location` VALUES(2377, 'Benjamín Aráoz', 143, 0);
INSERT INTO `location` VALUES(2378, 'Burruyacu', 143, 0);
INSERT INTO `location` VALUES(2379, 'Chicligasta', 143, 0);
INSERT INTO `location` VALUES(2380, 'Colombres', 143, 0);
INSERT INTO `location` VALUES(2381, 'Colorado del Valle', 143, 0);
INSERT INTO `location` VALUES(2382, 'Concepción', 143, 0);
INSERT INTO `location` VALUES(2383, 'Cruz Alta', 143, 0);
INSERT INTO `location` VALUES(2384, 'El Chañar', 143, 0);
INSERT INTO `location` VALUES(2385, 'El Mollar', 143, 0);
INSERT INTO `location` VALUES(2386, 'Famaillá', 143, 0);
INSERT INTO `location` VALUES(2387, 'Famaillá', 143, 0);
INSERT INTO `location` VALUES(2388, 'Gobernador Garmendia', 143, 0);
INSERT INTO `location` VALUES(2389, 'Graneros', 143, 0);
INSERT INTO `location` VALUES(2390, 'Independencia', 143, 0);
INSERT INTO `location` VALUES(2391, 'Juan B. Alberdi', 143, 0);
INSERT INTO `location` VALUES(2392, 'La Cocha', 143, 0);
INSERT INTO `location` VALUES(2393, 'La Ramada', 143, 0);
INSERT INTO `location` VALUES(2394, 'La Reducción', 143, 0);
INSERT INTO `location` VALUES(2395, 'La Trinidad', 143, 0);
INSERT INTO `location` VALUES(2396, 'Lamadrid', 143, 0);
INSERT INTO `location` VALUES(2397, 'Las Cejas', 143, 0);
INSERT INTO `location` VALUES(2398, 'Leales', 143, 0);
INSERT INTO `location` VALUES(2399, 'Los Ralos', 143, 0);
INSERT INTO `location` VALUES(2400, 'Los Sarmientos', 143, 0);
INSERT INTO `location` VALUES(2401, 'Lules', 143, 0);
INSERT INTO `location` VALUES(2402, 'Manuel García Fernández', 143, 0);
INSERT INTO `location` VALUES(2403, 'Monteagudo', 143, 0);
INSERT INTO `location` VALUES(2404, 'Monteros', 143, 0);
INSERT INTO `location` VALUES(2405, 'Ranchillos', 143, 0);
INSERT INTO `location` VALUES(2406, 'Rio Chico', 143, 0);
INSERT INTO `location` VALUES(2407, 'Río Colorado', 143, 0);
INSERT INTO `location` VALUES(2408, 'Río Seco', 143, 0);
INSERT INTO `location` VALUES(2409, 'San Pablo', 143, 0);
INSERT INTO `location` VALUES(2410, 'San Pedro de Colalao', 143, 0);
INSERT INTO `location` VALUES(2411, 'Santa Ana', 143, 0);
INSERT INTO `location` VALUES(2412, 'Santa Lucía', 143, 0);
INSERT INTO `location` VALUES(2413, 'Santa Rosa de Leales', 143, 0);
INSERT INTO `location` VALUES(2414, 'Simoca', 143, 0);
INSERT INTO `location` VALUES(2415, 'Taco Ralo', 143, 0);
INSERT INTO `location` VALUES(2416, 'Tafí del Valle', 143, 0);
INSERT INTO `location` VALUES(2417, 'Tafi Viejo', 143, 0);
INSERT INTO `location` VALUES(2418, 'Trancas', 143, 0);
INSERT INTO `location` VALUES(2419, 'Villa Belgrano', 143, 0);
INSERT INTO `location` VALUES(2420, 'Villa C. Hileret', 143, 0);
INSERT INTO `location` VALUES(2421, 'Villa Carmela', 143, 0);
INSERT INTO `location` VALUES(2422, 'Villa Fiad', 143, 0);
INSERT INTO `location` VALUES(2423, 'Villa Mariano Moreno', 143, 0);
INSERT INTO `location` VALUES(2424, 'Villa Quinteros', 143, 0);
INSERT INTO `location` VALUES(2425, 'Yerba Buena', 143, 0);
INSERT INTO `location` VALUES(231, 'Escobar', 116, 0);
INSERT INTO `location` VALUES(232, 'Tigre', 116, 0);
INSERT INTO `location` VALUES(233, 'General San Martín', 116, 0);
INSERT INTO `location` VALUES(2426, 'General Rodriguez', 117, 0);
INSERT INTO `location` VALUES(2427, 'Hurlingham', 117, 0);
INSERT INTO `location` VALUES(2428, 'Ituzaingó', 117, 0);
INSERT INTO `location` VALUES(2429, 'José C. Paz', 117, 0);
INSERT INTO `location` VALUES(2430, 'Malvinas Argentinas', 117, 0);
INSERT INTO `location` VALUES(2431, 'Marcos Paz', 117, 0);
INSERT INTO `location` VALUES(2432, 'Merlo', 117, 0);
INSERT INTO `location` VALUES(2433, 'Moreno', 117, 0);
INSERT INTO `location` VALUES(2434, 'San Miguel', 117, 0);
INSERT INTO `location` VALUES(2435, 'Tres de Febrero', 117, 0);
INSERT INTO `location` VALUES(2436, 'Almirante Brown', 118, 0);
INSERT INTO `location` VALUES(2437, 'Avellaneda', 118, 0);
INSERT INTO `location` VALUES(2438, 'Berazategui', 118, 0);
INSERT INTO `location` VALUES(2439, 'Esteban Echeverría', 118, 0);
INSERT INTO `location` VALUES(2440, 'Ezeiza', 118, 0);
INSERT INTO `location` VALUES(2441, 'Florencio Varela', 118, 0);
INSERT INTO `location` VALUES(2442, 'Lomas de Zamora', 118, 0);
INSERT INTO `location` VALUES(2443, 'Presidente Perón', 118, 0);
INSERT INTO `location` VALUES(2444, 'San Vicente', 118, 0);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL auto_increment,
  `menu_name` varchar(255) default '',
  `menu_parent` int(11) NOT NULL default '0',
  `menu_url` varchar(255) default '',
  `menu_order` int(5) NOT NULL default '0',
  `menu_state` int(1) NOT NULL default '0',
  PRIMARY KEY  (`menu_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` VALUES(1, 'ZonaJobs Educacion', 0, '#', 0, 1);
INSERT INTO `menu` VALUES(2, 'Inicio', 1, '/', 1, 1);
INSERT INTO `menu` VALUES(3, 'Carreras y Terciarios', 1, '/carreras-y-terciarios', 2, 1);
INSERT INTO `menu` VALUES(4, 'Test Vocacional', 1, '/test-vocacional', 5, 1);
INSERT INTO `menu` VALUES(7, 'Posgrados y Maestrías', 1, '/posgrados-y-maestrias', 3, 1);
INSERT INTO `menu` VALUES(12, 'Cursos', 1, '/cursos', 4, 1);
INSERT INTO `menu` VALUES(17, 'Notas', 1, '/notas', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `multimedia`
--

DROP TABLE IF EXISTS `multimedia`;
CREATE TABLE `multimedia` (
  `multimedia_id` int(11) NOT NULL auto_increment,
  `multimedia_typeid` int(11) NOT NULL default '0',
  `multimedia_source` varchar(10) NOT NULL default '',
  `multimedia_weight` int(15) NOT NULL default '0',
  `multimedia_parent` int(11) NOT NULL default '0',
  `multimedia_title` varchar(500) default '',
  `multimedia_content` text,
  `multimedia_state` int(1) NOT NULL default '0',
  `creation_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `creation_userid` int(4) NOT NULL default '0',
  `creation_usertype` varchar(50) default '',
  `modification_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `modification_userid` int(4) NOT NULL default '0',
  `modification_usertype` varchar(50) default '',
  `object_custom` text,
  PRIMARY KEY  (`multimedia_id`),
  FULLTEXT KEY `busqueda` (`multimedia_title`,`multimedia_content`,`object_custom`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

--
-- Dumping data for table `multimedia`
--


-- --------------------------------------------------------

--
-- Table structure for table `multimedia_category`
--

DROP TABLE IF EXISTS `multimedia_category`;
CREATE TABLE `multimedia_category` (
  `multimedia_id` int(11) NOT NULL default '0',
  `category_id` int(11) NOT NULL default '0',
  `category_parentid` int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `multimedia_category`
--


-- --------------------------------------------------------

--
-- Table structure for table `multimedia_deleted`
--

DROP TABLE IF EXISTS `multimedia_deleted`;
CREATE TABLE `multimedia_deleted` (
  `multimedia_id` int(11) NOT NULL auto_increment,
  `multimedia_typeid` int(11) NOT NULL default '0',
  `multimedia_source` varchar(10) NOT NULL default '',
  `multimedia_weight` int(15) NOT NULL default '0',
  `multimedia_parent` int(11) NOT NULL default '0',
  `multimedia_title` varchar(500) default '',
  `multimedia_content` text,
  `multimedia_state` int(1) NOT NULL default '0',
  `creation_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `creation_userid` int(11) NOT NULL default '0',
  `creation_usertype` varchar(50) default '',
  `modification_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `modification_userid` int(11) NOT NULL default '0',
  `modification_usertype` varchar(50) default '',
  `object_custom` text,
  PRIMARY KEY  (`multimedia_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

--
-- Dumping data for table `multimedia_deleted`
--

INSERT INTO `multimedia_deleted` VALUES(48, 1, 'jpg', 102303, 0, 'tumblr_lqwnbayekS1qzr53co1_1280.jpg', '', 0, '2013-11-04 21:56:01', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"853";s:10:"height-att";s:4:"1280";}');
INSERT INTO `multimedia_deleted` VALUES(47, 1, 'jpg', 127035, 0, 'tumblr_lqvh9bbxxo1qzr53co1_1280.jpg', '', 0, '2013-11-04 21:56:00', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"600";s:10:"height-att";s:3:"916";}');
INSERT INTO `multimedia_deleted` VALUES(46, 1, 'jpg', 202316, 0, 'tumblr_lqunz5Y6u81qzr53co1_1280.jpg', '', 0, '2013-11-04 21:56:00', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"567";s:10:"height-att";s:3:"850";}');
INSERT INTO `multimedia_deleted` VALUES(45, 1, 'jpg', 286395, 0, 'tumblr_lqujey7Rnx1qzr53co1_1280.jpg', '', 0, '2013-11-04 21:56:00', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"967";s:10:"height-att";s:4:"1280";}');
INSERT INTO `multimedia_deleted` VALUES(44, 1, 'jpg', 68139, 0, 'tumblr_lqqt8bRHTv1qzr53co1_1280.jpg', '', 0, '2013-11-04 21:55:59', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"570";s:10:"height-att";s:3:"856";}');
INSERT INTO `multimedia_deleted` VALUES(43, 1, 'png', 318184, 0, 'tumblr_mgc20zDlSz1r5vp1oo1_500.png', '', 0, '2013-11-04 21:50:46', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}');
INSERT INTO `multimedia_deleted` VALUES(42, 1, 'jpg', 80194, 0, 'tumblr_me22eqHqeu1r5vp1oo1_r3_500.jpg', '', 0, '2013-11-04 21:50:45', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}');
INSERT INTO `multimedia_deleted` VALUES(41, 1, 'jpg', 136495, 0, 'tumblr_me5umiHgVb1r5vp1oo1_500.jpg', NULL, 0, '2013-11-04 21:47:46', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}');
INSERT INTO `multimedia_deleted` VALUES(40, 1, 'jpg', 165862, 0, 'tumblr_m79lttf60u1qlo9hgo1_500.jpg', NULL, 0, '2013-11-04 21:47:42', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}');
INSERT INTO `multimedia_deleted` VALUES(39, 1, 'jpg', 97365, 0, 'tumblr_m24bgh0e6d1r5vp1oo1_500.jpg', NULL, 0, '2013-11-04 21:47:38', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"500";s:10:"height-att";s:3:"333";}');
INSERT INTO `multimedia_deleted` VALUES(38, 1, 'jpg', 381002, 0, '142368964_adriana_lima_vsbombshell2_122_130lo.jpg', ' ', 0, '2013-11-04 21:25:15', 0, '', '0000-00-00 00:00:00', 0, '', 'a:1:{s:4:"tags";s:0:"";}');
INSERT INTO `multimedia_deleted` VALUES(37, 1, 'jpg', 238580, 0, '323983708_rosie_huntington_whiteley_maxim2_123_451lo.jpg', ' ', 0, '2013-11-04 21:23:54', 0, '', '0000-00-00 00:00:00', 0, '', 'a:1:{s:4:"tags";s:0:"";}');
INSERT INTO `multimedia_deleted` VALUES(36, 1, 'jpg', 193321, 0, '936full-irina-shayk.jpg', ' ', 0, '2013-11-01 16:55:32', 0, '', '0000-00-00 00:00:00', 0, '', 'a:1:{s:4:"tags";s:0:"";}');
INSERT INTO `multimedia_deleted` VALUES(35, 1, 'jpg', 449331, 0, '73709-original.jpg', NULL, 0, '2013-10-29 22:47:48', 0, '', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"580";s:10:"height-att";s:3:"600";}');
INSERT INTO `multimedia_deleted` VALUES(29, 1, 'jpg', 35312, 0, 'Estudiar posgrados.jpg', '', 0, '2013-01-16 14:34:19', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"400";s:10:"height-att";s:3:"602";}');
INSERT INTO `multimedia_deleted` VALUES(31, 1, 'jpg', 20624, 0, 'Un pasaporte.jpg', '', 0, '2013-01-16 14:34:19', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"400";s:10:"height-att";s:3:"267";}');
INSERT INTO `multimedia_deleted` VALUES(30, 1, 'jpg', 37262, 0, 'Mayor capacitacion.jpg', '', 0, '2013-01-16 14:34:19', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:2:{s:9:"width-att";s:3:"400";s:10:"height-att";s:3:"602";}');
INSERT INTO `multimedia_deleted` VALUES(28, 1, 'jpg', 14868, 0, '5 profesiones', '  ', 0, '2013-01-16 14:34:19', 1, 'backend', '0000-00-00 00:00:00', 0, '', 'a:3:{s:9:"width-att";s:3:"400";s:10:"height-att";s:3:"266";s:4:"tags";s:0:"";}');

-- --------------------------------------------------------

--
-- Table structure for table `multimedia_object`
--

DROP TABLE IF EXISTS `multimedia_object`;
CREATE TABLE `multimedia_object` (
  `object_id` int(11) NOT NULL default '0',
  `multimedia_id` int(11) NOT NULL default '0',
  `relation_order` int(3) NOT NULL default '0',
  `object_typeid` int(11) NOT NULL default '0',
  `multimedia_typeid` int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `multimedia_object`
--


-- --------------------------------------------------------

--
-- Table structure for table `object`
--

DROP TABLE IF EXISTS `object`;
CREATE TABLE `object` (
  `object_id` int(11) NOT NULL auto_increment,
  `object_typeid` int(11) NOT NULL default '0',
  `object_parent` int(11) NOT NULL default '0',
  `object_title` varchar(500) default '',
  `object_shorttitle` varchar(255) default '',
  `object_content` text,
  `object_summary` text,
  `object_tags` varchar(255) default NULL,
  `creation_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `creation_userid` int(4) NOT NULL default '0',
  `creation_usertype` varchar(50) default '',
  `modification_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `modification_userid` int(4) NOT NULL default '0',
  `modification_usertype` varchar(50) default '',
  `publication_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `publication_userid` int(4) NOT NULL default '0',
  `object_state` int(1) NOT NULL default '0',
  `site_id` int(11) NOT NULL default '0',
  `location_id` int(11) NOT NULL default '0',
  `object_custom` text,
  PRIMARY KEY  (`object_id`),
  FULLTEXT KEY `busqueda` (`object_title`,`object_content`,`object_custom`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=180 ;

--
-- Dumping data for table `object`
--

INSERT INTO `object` VALUES(175, 3, 0, 'Quienes Somos', 'quienes-somos', '<p class="p1"><span class="s1"><strong>ZonaJobs · Educación</strong></span><span class="s2"><strong> </strong>es un portal diseñado para facilitar la interacción entre potenciales estudiantes e instituciones educativas. </span></p>\r\n<p class="p1"><span class="s1"><strong>ZonaJobs · Educación</strong></span><span class="s2"><strong> </strong>tiene los siguientes objetivos:<br /><strong></strong></span></p>\r\n<p class="p1"><span class="s2"><strong>1) Que todas las personas encuentren su verdadera vocación.</strong></span></p>\r\n<p class="p1"><span class="s1"><strong>2) Que todos nuestros usuarios puedan crecer profesional y personalmente realizando carreras, cursos y posgrados.</strong></span></p>\r\n<p class="p1"><span class="s1">Somos parte de </span><span class="s2"><strong>ZonaJobs</strong></span><span class="s1">, el portal de empleos líder de </span>Latinoamérica. </p>\r\n<p class="p1"><span class="s1">Desde el 2006 operamos en Argentina, Brasil, Chile, Colombia, México, Perú y Venezuela. </span></p>\r\n<p class="p1"><span class="s1">Si tienes alguna duda o sugerencia para hacernos, escríbenos a través de nuestro</span><span class="s2"> <a href="http://www.zonajobs.com.ar/varios/contactenos.asp"><span class="s3">formulario de contacto.</span></a></span></p>\r\n<p class="p1"><span class="s1"><br /></span></p>', NULL, NULL, '2013-02-26 18:46:43', 1, 'backend', '2013-02-26 18:55:58', 1, 'backend', '2013-02-26 18:57:37', 1, 1, 0, 0, 'a:3:{s:9:"metatitle";s:13:"Quienes Somos";s:15:"metadescription";s:0:"";s:4:"tags";s:0:"";}');
INSERT INTO `object` VALUES(176, 3, 0, 'Preguntas frecuentes', 'preguntas-frecuentes', '<p><strong>Preguntas frecuentes para Usuarios</strong><br /> <a href="#preg1">¿Cuánto cuesta utilizar los servicios de ZonaJobs Educación?</a><br /> <a href="#preg2">¿Tengo que estar registrado para poder buscar una carrera?<br /> </a><a href="#preg3">¿Cómo busco carreras, cursos o posgrados en el sitio?<br /> </a><a href="#preg4">¿Cómo busco por palabra clave en el buscador?</a><a href="#preg3"><br /> </a><a href="#preg5">¿Puedo obtener más datos acerca de una carrera, curso o posgrado?</a><a href="#preg3"><br /> </a><a href="#preg6">¿Puedo obtener más datos acerca de una Universidad específica?</a><a href="#preg3"><br /> </a><a href="#preg7">¿Qué sucede con mis datos al llenar el formulario de contacto?</a><a href="#preg3"><br /> </a><a href="#preg8">¿Cómo hace una institución para contactarse conmigo?</a><a href="#preg3"><br /> </a><a href="#preg9">Todavía no definí lo que quiero estudiar, ¿qué debo hacer?</a><a href="#preg3"><br /> </a><a href="#preg10">Realicé el test vocacional pero tengo algunas dudas sobre el resultado, ¿qué puedo hacer?</a><a href="#preg3"><br /> </a><a href="#preg11">¿Qué es una carrera universitaria?</a><a href="#preg3"><br /> </a><a href="#preg12">¿Por qué estudiar una carrera universitaria o un terciario? </a><a href="#preg3"><br /> </a><a href="#preg13">¿Qué es un posgrado?</a><a href="#preg3"><br /> </a><a href="#preg14">¿Por qué debo estudiar un posgrado?</a><a href="#preg3"><br /> </a><a href="#preg15">¿Qué es un curso?</a><a href="#preg3"><br /> </a><a href="#preg16">¿Por qué debo estudiar un curso?</a><a href="#preg3"><br /> </a><a href="#preg17">Quiero realizar una consulta o sugerencia, ¿cómo lo hago?</a></p>\r\n<p><strong>Preguntas frecuentes para Instituciones Educativas</strong><br /> <a href="#preg18">¿Cómo funciona ZonaJobs Educación?</a><br /> <a href="#preg19">¿Cómo registro mi Institución?</a><br /> <a href="#preg20">¿Cómo publico un curso, carrera o posgrado?</a><br /> <a href="#preg21">¿Qué tipo de instituciones pueden registrarse en ZonaJobs Educación?</a><br /> <a href="#preg22">¿Cómo destaco mi instituto? </a><br /> <a href="#preg23">¿Puedo destacar una carrera específica?</a><br /> <a href="#preg24">¿Cómo contacto a los interesados en mi institución?</a><br /> <a href="#preg25">Quiero realizar una consulta o sugerencia a ZonaJobs Educación, ¿cómo puedo hacer?</a></p>\r\n<p> </p>\r\n<p id="preg1"><strong>¿Cuánto cuesta utilizar los servicios de ZonaJobs Educación?</strong></p>\r\n<p>El servicio de búsqueda de ofertas educativas de <strong>ZonaJobs Educación</strong> es <strong>totalmente gratuito</strong> y te permitirá solicitar información a todos los cursos, carreras y posgrados que desees.</p>\r\n<p id="preg2"><strong>¿Tengo que estar registrado para poder buscar una carrera?</strong></p>\r\n<p>Para utilizar el servicio de búsqueda de carrera no necesitas generar un usuario y una contraseña, puedes hacerlo libremente y solicitar información a todas las instituciones que desees de manera libre y gratuita. </p>\r\n<p id="preg3"><strong>¿Cómo busco carreras, cursos o posgrados en el sitio?</strong></p>\r\n<p>En la página principal de <strong>ZonaJobs Educación</strong>, encontrarás un <strong>Buscador de Carreras</strong> que tiene 4 campos de búsqueda. Ellos son: <strong>Palabra Clave</strong>, <strong>Ubicación (por zona), Modalidad (si es presencial o a distancia) y Nivel (si buscas una carrera, será grado)</strong>. Deberás seleccionar al menos una opción para que se listen todas las carreras que cumplan con los criterios que seleccionaste.</p>\r\n<p id="preg4"><strong>¿Cómo busco por palabra clave en el buscador?</strong></p>\r\n<p>Simplemente deberás escribir una o varias palabras en el campo <strong>Palabra Clave</strong> que se encuentra dentro del buscador de la página principal de <strong>ZonaJobs Educación</strong>. </p>\r\n<p id="preg5"><strong>¿Puedo obtener más datos acerca de una carrera, curso o posgrado?</strong></p>\r\n<p>Si. Para obtener más datos de una oferta educativa debes hacer clic en “Solicitar información” y llenar los datos de contacto solicitados, la institución se contactará contigo a la brevedad para explicarte los detalles que te interesen sobre la carrera, curso o posgrado.</p>\r\n<p id="preg6"><strong>¿Puedo obtener más datos acerca de una Universidad específica?</strong></p>\r\n<p>Si. Para ver los datos de una Universidad o Institución específica puedes escribir su nombre en el buscador o hacer clic sobre su nombre o su logo. Allí entrarás al perfil de la universidad y podrás ver su resumen, además podrás presionar el botón “Solicitar información” y completar los datos de contacto solicitados, la institución se contactará contigo a la brevedad para explicarte los detalles que te interesen conocer en profundidad.</p>\r\n<p id="preg7"><strong>¿Qué sucede con mis datos al llenar el formulario de contacto?</strong></p>\r\n<p>Tus datos sólo se enviarán a las universidades o instituciones que sean de tu interés para que las mismas te contacten y puedan detallarte su plan de estudios. ZonaJobs Educación tiene como objetivo facilitar la interacción entre los estudiantes aplicantes y las instituciones educativas, y no interfiere en el proceso de contacto de estas últimas. </p>\r\n<p>Lee nuestros términos y condiciones para saber más. </p>\r\n<p id="preg8"><strong>¿Cómo hace una institución para contactarse conmigo?</strong></p>\r\n<p>Si has llenado correctamente tus datos de contacto, la institución te contactará por correo electrónico o por teléfono, según su preferencia. Te recordamos que ZonaJobs Educación sólo facilita la interacción entre los estudiantes aplicantes y las instituciones, y no interfiere en el proceso de contacto de las últimas.</p>\r\n<p id="preg9"><strong>Todavía no definí lo que quiero estudiar, ¿qué debo hacer?</strong></p>\r\n<p>Si todavía no encontraste tu verdadera pasión, te sugerimos realizar nuestro test vocacional online, haciendo clic aquí. El test no te llevará más de 5 minutos y te permitirá ver de una manera más clara el ámbito en el que puedes desempeñarte de manera efectiva. </p>\r\n<p id="preg10"><strong>Realicé el test vocacional pero tengo algunas dudas sobre el resultado, ¿qué puedo hacer?</strong></p>\r\n<p>Si tienes dudas sobre el resultado de tu test, puedes asesorarte con CATAIFE, Consultora de carrera, ingresando <a href="http://www.consultoradecarrera.com.ar/">aquí</a> o enviando un correo a info@consultoradecarrera.com.ar . Un especialista te asesorará por correo electrónico y podrás concretar una entrevista personal en caso de que lo desees.  </p>\r\n<p id="preg11"><strong>¿Qué es una carrera universitaria?</strong></p>\r\n<p>Una carrera o terciario se refiere al proceso en donde, después de haber cursado la educación secundaria o educación media, se estudia una carrera profesional y se obtiene una titulación superior. El requisito para ingresar es haber finalizado la educación secundaria y es común que exista una selección de los postulantes basados en el rendimiento escolar de la secundaria o exámenes de ingreso. Lee nuestras notas para saber más. </p>\r\n<p id="preg12"><strong>¿Por qué estudiar una carrera universitaria o un terciario? </strong></p>\r\n<ul class="bullets">\r\n<li>Te vuelves más capacitado y valorado en el mercado laboral. </li>\r\n<li>8 de cada 10 personas con título universitario se encuentran trabajando actualmente. </li>\r\n<li>El 82% de las búsquedas de las empresas en la base de candidatos de ZonaJobs son a personas con título universitario. </li>\r\n</ul>\r\n<p id="preg13"><strong>¿Qué es un posgrado?</strong></p>\r\n<p>Un posgrado comprende los títulos de maestría (también llamado máster) y doctorado. Estos son la última fase de la educación formal y tienen como antecedente obligatorio la titulación de grado, además tiene otros requisitos (como la experiencia laboral y la edad), que varían según la institución. Recomendamos realizar el posgrado en una institución distinta a la que has realizado tus estudios de grado. Lee nuestras notas para saber más.</p>\r\n<p id="preg14"><strong>¿Por qué debo estudiar un posgrado?</strong></p>\r\n<p>Sólo el 15% de los universitarios realizaron un posgrado, por lo que:</p>\r\n<ul class="bullets">\r\n<li>Te vuelves más valorado en el mercado laboral, ampliando tus capacidades de negociación frente a una empresa. </li>\r\n<li>8 de cada 10 personas que realizaron un posgrado tienen un puesto de alta jerarquía. </li>\r\n</ul>\r\n<p id="preg15"><strong>¿Qué es un curso?</strong></p>\r\n<p>Los cursos son muchos y muy variados. Generalmente se utilizan para capacitarse en un tema específico ya que son de corta duración. Si eliges un curso adecuado a tu carrera o profesión, se considerará un plus en tu CV. Lee nuestras notas para saber más.</p>\r\n<p id="preg16"><strong>¿Por qué debo estudiar un curso?</strong></p>\r\n<ul class="bullets">\r\n<li>Adquieres conocimientos útiles fáciles de aplicar a tu futuro empleo. </li>\r\n<li>Te vuelves más especializado. </li>\r\n<li>Te vuelves más competitivo y valorado en el mercado laboral. </li>\r\n</ul>\r\n<p id="preg17"><strong>Quiero realizar una consulta o sugerencia, ¿cómo lo hago?</strong></p>\r\n<p>Si tienes una duda o una sugerencia para realizar puedes llenar nuestro formulario de contacto haciendo clic aquí. En ZonaJobs Educación queremos seguir mejorando el servicio ofrecido, por lo tanto tu opinión es muy valiosa para nosotros. </p>\r\n<p id="preg18"><strong>Preguntas frecuentes para Instituciones Educativas</strong></p>\r\n<p><strong>¿Cómo funciona ZonaJobs Educación?</strong></p>\r\n<p>ZonaJobs Educación actúa como nexo entre las instituciones y los potenciales estudiantes, brindándoles una guía completa de todas las carreras, cursos y posgrados disponibles en su país. En caso de estar interesados, los usuarios completarán un formulario de datos para que usted pueda contactarse con ellos y explicarles los detalles de su oferta académica. </p>\r\n<p id="preg19"><strong>¿Cómo registro mi Institución?</strong></p>\r\n<p>Para anunciar su institución / universidad y figurar en el buscador de <strong>ZonaJobs Educación</strong>, haga clic aquí. Darse de alta en el sitio y publicar sus carreras, cursos y posgrados es <strong>totalmente gratuito</strong>. </p>\r\n<p>Una vez que complete nuestro formulario, un ejecutivo lo contactará para asesorarlo en el proceso de publicación. </p>\r\n<p id="preg20"><strong>¿Cómo publico un curso, carrera o posgrado?</strong></p>\r\n<p>Si ya está dado de alta, puede contactarse con su ejecutivo para que lo asesore con el proceso. Si aún no se registró, debe llenar el formulario de registro haciendo clic aquí. Una vez que complete el formulario, se le asignará un ejecutivo que lo asesorará con la publicación de sus ofertas educativas. </p>\r\n<p id="preg21"><strong>¿Qué tipo de instituciones pueden registrarse en ZonaJobs Educación?</strong></p>\r\n<p>En ZonaJobs Educación pueden registrarse todo tipo de instituciones educativas, ya sean universidades, terciarios, institutos, escuelas, talleres, academias, y todo aquel que quiera anunciar una oferta educativa de cualquier tipo. </p>\r\n<p id="preg22"><strong>¿Cómo destaco mi instituto? </strong></p>\r\n<p>Si quiere destacar su instituto, puede escribirnos a <a href="mailto:instituciones@zonajobs.com">instituciones@zonajobs.com</a>indicando su país. Uno de nuestros ejecutivos lo asesorará para que pueda llenar sus aulas de la manera más rápida y efectiva. </p>\r\n<p id="preg23"><strong>¿Puedo destacar una carrera específica?  </strong></p>\r\n<p>Si quiere destacar una carrera, curso o posgrado específico, puede escribirnos según su país:</p>\r\n<p>Argentina: <a href="mailto:instituciones@zonajobs.com">instituciones@zonajobs.com.ar</a><br /> Chile: <a href="mailto:instituciones@zonajobs.cl">instituciones@zonajobs.cl</a><br /> Colombia: <a href="mailto:instituciones@zonajobs.com.co">instituciones@zonajobs.com.co</a><br /> México: <a href="mailto:instituciones@zonajobs.com.mx">instituciones@zonajobs.com.mx</a><br /> Venezuela: <a href="mailto:instituciones@zonajobs.com.ve">instituciones@zonajobs.com.ve</a></p>\r\n<p>Uno de nuestros ejecutivos lo asesorará para que pueda llenar sus aulas de la manera más rápida y efectiva. </p>\r\n<p id="preg24"><strong>¿Cómo contacto a los interesados en mi institución?</strong></p>\r\n<p>Podrá contactar a los usuarios de manera telefónica o por correo electrónico, y otorgar una entrevista en caso de ser necesario. Le recordamos que ZonaJobs Educación tiene como objetivo facilitar la interacción entre los estudiantes aplicantes y las instituciones educativas, y no interfiere en el proceso de contacto ni en las entrevistas personales. </p>\r\n<p id="preg25"><strong>Quiero realizar una consulta o sugerencia a ZonaJobs Educación, ¿cómo puedo hacer?</strong></p>\r\n<p>Para contactarnos, puede escribirnos a <a href="mailto:instituciones@zonajobs.com">instituciones@zonajobs.com</a> detallando su país. Allí podrá reflejarnos sus dudas, inquietudes y sugerencias. En ZonaJobs Educación queremos seguir mejorando el servicio ofrecido, por lo tanto su opinión es muy valiosa para nosotros.</p>', NULL, NULL, '2013-02-26 18:57:50', 1, 'backend', '2014-07-01 11:40:02', 1, 'backend', '0000-00-00 00:00:00', 0, 0, 0, 0, 'a:3:{s:4:"tags";s:0:"";s:9:"metatitle";s:20:"Preguntas frecuentes";s:15:"metadescription";s:0:"";}');
INSERT INTO `object` VALUES(173, 1, 0, 'Los posgrados, un pasaporte a los mejores puestos ejecutivos', 'los-posgrados-un-pasaporte-a-los-mejores-puestos-ejecutivos', '<p class="p1"><span class="s1">La oferta de estudios se amplía al ritmo de la evolución del mercado laboral</span></p>\r\n<p class="p2"><span class="s1">Tener o no tener un título de MBA puede ser un factor discriminante para un joven profesional que aspire a ocupar un puesto ejecutivo en alguna corporación importante, por lo que hoy son pocos los que pueden darse el lujo de no contar en su haber con una competencia semejante.</span></p>\r\n<p class="p2"><span class="s1">Felizmente, en la Argentina los jóvenes profesionales y también los profesionales jóvenes tienen a mano una creciente oferta de estudios de posgrado, aunque no todas las instituciones ofrecen programas rigurosamente aprobados por la Comisión Nacional de Evaluación y Acreditación Universitaria (Coneau). Durante la próxima feria de Consortium, que se realizará el 29 y 30 de este mes, algunas de las universidades más prestigiosas estarán presentes para informar a los visitantes sobre objetivos, metodologías y contenidos que mejor se ajusten a las expectativas personales. Incluso en la feria se realizará el Ciclo de Capacitación al Joven Profesional (las vacantes son limitadas, por más información comunicarse por el 5520-0004).</span></p>\r\n<p class="p2"><span class="s1">"Para nosotros, posgrado son todas aquellas actividades académicas que superan determinado número de horas, las que están aprobadas por la Coneau -afirma Luis Vergani, director de posgrados del ITBA-. Desde hace años en la Argentina esta legislado por ley el alcance de esta palabra con sus tres categorizaciones, que son especialización, maestría y doctorado. Es decir, no se puede utilizar livianamente."</span></p>\r\n<p class="p2"><span class="s1">Con una carga de 365 horas netas mínimas de clase presenciada, el ITBA cuenta hoy con 500 alumnos cursando posgrados y otros 700 en distintos programas de educación continua, donde el más demandado es el de Proyect Managment. Por tratarse de áreas específicas de la tecnología, la casa se reserva el derecho de admitir a los recién egresados de las carreras de grado.</span></p>\r\n<p class="p3"><span class="s1">"La mayoría de los estudiantes tienen más de 30 años. Creemos que para el grueso de nuestros cursos hace falta traer algún bagaje de experiencia aparte del estudio, es decir, no recibimos gente recién salida del grado, menos en temas enimentemente tecnológicos, que son los más numerosos y que combinan la tecnología, las finanzas, la comercialización y las clínicas de gestión. Pensamos que es imposible de cumplir esa promesa que algunos les hacen a los jóvenes, de que por ser un gran promedio una persona de 24 años puede cursar un MBA y a los 26 ya estar en el fast track", agrega Vergani. La evolución del mercado plantea nuevos desafíos y las universidades se ajustan a ellos a la hora de diseñar sus planes de estudios. El Departamento de Economía de la Universidad Torcuato Di Tella agregó a su menú dos programas de educación ejecutiva que antes de 2001 no existían: el de Econometría y el de Actualización en Economía Avanzada. Respecto de otras áreas de estudio, inauguró la maestría en Estudios Internacionales, el máster en Periodismo, el programa de Economía Urbana se convirtió en maestría y se lanzó el Programa Internacional de Derecho Tributario. Los estudiantes, por ejemplo, que cursan posgrados en finanzas son en su mayoría contadores y economistas egresados de la UBA cuyas edades rondan los 27 y 30 años. "Los más concurridos son los posgrados en negocios: MBA, Executive MBA y la Maestría en Finanzas -explica Karina Chrempacz, directora de Admisiones de Posgrado-. Seguramente se debe a que son los que tienen mayor salida laboral y repago de la inversión. El mercado lo pide. Aunque la persona no tenga muchas ganas de realizar un posgrado en estas áreas, sus trabajos lo requieren, o creen que cursando estos programas tendrán mejores oportunidades laborales, y económicas." En el caso de Ucema, durante la década del 90 amplió sus posgrados y en especial la maestría en Administración de Empresas se orientó a tres nuevas áreas: Mercado de Capitales, Finanzas Corporativas y Aspectos Legales de las Finanzas, que actualmente cursan cerca de 130 alumnos de más de 26 años y con experiencia laboral. "Estas reorientaciones fueron inauguradas en 1995 -explica Edgardo Zablostsky, director de la maestría en Finanzas-. En el caso de los abogados, necesitan conocimientos de finanzas, en especial si cumplen roles importantes en compañías financieras." </span></p>\r\n<p class="p4"> </p>\r\n<p class="p5"><span class="s2">Por: <a href="http://www.lanacion.com.ar/autor/marina-gambier-282"><span class="s3"><strong>Marina Gambier</strong></span></a></span><span class="s4"> </span></p>\r\n<p class="p6"><span class="s4">Fuente: <a href="http://www.lanacion.com.ar/"><span class="s5">La Nación</span></a></span></p>', '', '', '2013-02-18 17:47:22', 1, 'backend', '2013-11-04 21:25:49', 1, 'backend', '2013-11-04 21:25:52', 1, 1, 0, 0, 'a:3:{s:9:"metatitle";s:60:"Los posgrados, un pasaporte a los mejores puestos ejecutivos";s:15:"metadescription";s:42:"                                          ";s:6:"header";s:0:"";}');
INSERT INTO `object` VALUES(161, 3, 0, 'Términos y condiciones Argentina', 'terminos-y-condiciones', '<p> <strong>1. CONDICIONES GENERALES Y ACEPTACIÓN.</strong></p>\r\n<p><span class="s1">Esta página establece las "Condiciones Generales" que regulan el uso de los contenidos y servicios que integran el sitio web _______________ (en adelante, el "Sitio Web"). Por favor, lea esta página atentamente. SI NO ACEPTA ESTAS CONDICIONES GENERALES, NO UTILICE ESTE SITIO WEB. CUALQUIER PERSONA QUE NO ACEPTE ESTAS CONDICIONES GENERALES, LAS CUALES TIENEN CARÁCTER OBLIGATORIO Y VINCULANTE, DEBERÁ ABSTENERSE DE UTILIZAR EL SITIO WEB Y/O LOS SERVICIOS OFRECIDOS.</span></p>\r\n<p class="p2"><span class="s1">Si el Usuario utiliza el Sitio Web, se entenderá que ha aceptado plenamente y sin reservas las Condiciones Generales que estén vigentes en el momento de acceso. Por lo tanto, el Usuario se obliga a cumplir con todas las disposiciones contenidas en estas Condiciones Generales, bajo las leyes aplicables, estatutos, reglamentos y regulaciones concernientes al uso del Sitio Web. DRIDCO S.A., titular del Sitio Web (en adelante,"DRIDCO") se reserva el derecho de revisar estas Condiciones Generales en cualquier momento, actualizando y/o modificando esta página.</span></p>\r\n<p class="p2"><span class="s1">Usted debería visitar esta página cada vez que acceda al Sitio Web para revisar las Condiciones Generales, puesto que las mismas son obligatorias y vinculantes. Los términos "Usted" y "Usuario" se emplean aquí para referirse a todos las personas físicas y/o jurídicas que por cualquier razón accedan al Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Asimismo, debido a que ciertos servicios y contenidos ofrecidos a los Usuarios a través del Sitio Web pueden contener normas específicas que reglamentan, complementan y/o modifiquen a las presentes Condiciones Generales (en adelante las “Condiciones Particulares”), se recomienda a los Usuarios tomar conocimiento específico de ellas antes de la utilización de dichos servicios.</span></p>\r\n<p class="p2"><span class="s1"><strong>2. ACCESO AL SITIO WEB. USO DEL MATERIAL.</strong></span></p>\r\n<p class="p2"><span class="s1"><strong>2.1. Acceso y utilización del Sitio Web. Autorización de uso de marca/logo.</strong></span></p>\r\n<p class="p2"><span class="s1">El acceso y utilización del Sitio Web no exige la previa suscripción o registro del Usuario. Sin perjuicio de ello, la utilización de algunos servicios que se ofrecen a través del Sitio Web requiere la suscripción o registro del Usuario y/o el pago de un precio, conforme se establece en las Condiciones Particulares aplicables al cada servicio.</span></p>\r\n<p class="p2"><span class="s1">Todo Usuario registrado autoriza expresamente a DRIDCO a incorporar en el Sitio Web, a exclusivo criterio de este último, el logo/marca de titularidad del Usuario que ha contratado al menos uno de los servicios provistos a través de dicho Sitio Web, con el único fin de referenciar a dicho Usuario como cliente del Sitio Web.</span></p>\r\n<p class="p2"><span class="s1"><strong>2.2. Utilización del Sitio Web.</strong></span></p>\r\n<p class="p2"><span class="s1">El Usuario se compromete a utilizar el Sitio Web de conformidad con la ley, estas Condiciones Generales, las Condiciones Particulares aplicables, así como con la moral y buenas costumbres generalmente aceptadas y el orden público.</span></p>\r\n<p class="p2"><span class="s1">El Usuario se obliga a abstenerse de utilizar el Sitio Web con fines o efectos ilícitos, contrarios a lo establecido en las Condiciones Generales, lesivos de los derechos e intereses de terceros, o que de cualquier forma puedan dañar, inutilizar, sobrecargar o deteriorar el Sitio Web o impedir la normal utilización  del Sitio Web por parte de los Usuarios.</span></p>\r\n<p class="p2"><span class="s1"><strong>2.3. Utilización del contenido del Sitio Web.</strong></span></p>\r\n<p class="p2"><span class="s1">DRIDCO le autoriza a visualizar y/o descargar (bajar) una única copia de los contenidos del Sitio Web y exclusivamente para su uso personal y no comercial. Los contenidos de este Sitio Web, tales como texto, gráficos, imágenes, logos, iconos de botón, software y cualquier otro material, todo lo cual designaremos como "el Contenido", están protegidos por la legislación sobre propiedad industrial e intelectual (Derechos de Autor, copyright, marcas registradas). Todo el Contenido es propiedad de DRIDCO y/o de cualquier otra sociedad vinculada, de sus proveedores de contenido o de sus clientes. La compilación (es decir, la recopilación, la disposición y el montaje) de todos los contenidos de este Sitio Web es de propiedad exclusiva de DRIDCO y/o de sus empresas vinculadas y está protegida por la legislación sobre propiedad industrial e intelectual de Argentina. El uso no autorizado del Contenido puede suponer la violación de la legislación sobre propiedad intelectual o industrial (derechos de autor, marca registrada, etc.) y de otras leyes aplicables.</span></p>\r\n<p class="p2"><span class="s1">Usted debe observar, en cualquier copia que haga del Contenido, todas las advertencias sobre derechos de autor, marca registrada, marca de servicio y otras relativas a los derechos de propiedad industrial o intelectual contenidas en el Contenido original. No podrá vender o modificar el Contenido o reproducirlo, exhibirlo, representarlo en público, distribuirlo, o hacer otro uso de este Contenido con fines comerciales o de difusión. Está prohibido el uso del Contenido en cualquier otro sitio de la web o en otro entorno de ordenadores interconectados para cualquier fin.</span></p>\r\n<p class="p2"><span class="s1">Usted no copiará ni adaptará el código HTML que DRIDCO ha creado para generar sus páginas. Dicho código se halla protegido también por los derechos de propiedad intelectual (copyright) de DRIDCO o de cualquier otra sociedad vinculada.</span></p>\r\n<p class="p2"><span class="s1"><strong>2.4. Uso permitido del Sitio</strong></span></p>\r\n<p class="p2"><span class="s2">Reglas generales</span><span class="s1">: No está permitido a los Usuarios utilizar el Sitio Web para transmitir, distribuir, almacenar o destruir material (a) violando las leyes o regulaciones vigentes, (b) de forma que infrinjan el derecho de autor, la marca registrada, el secreto comercial o cualquier otro derecho de propiedad intelectual o industrial de terceros o violando la confidencialidad, imagen pública o demás derechos personales de otras personas, o (c) que sea difamatorio, obsceno, amenazador, injurioso u ofensivo.</span></p>\r\n<p class="p2"><span class="s2">Reglas de Seguridad del Sitio Web</span><span class="s1">: Se prohíbe a los Usuarios violar o intentar violar la seguridad del Sitio Web, incluyendo pero no limitándose a: (a) acceder a datos que no estén destinados a tal usuario o entrar en un servidor o cuenta cuyo acceso no está autorizado al Usuario, (b) evaluar o probar la vulnerabilidad de un sistema o red, o violar las medidas de seguridad o identificación sin la adecuada autorización, (c) intentar impedir el servicio a cualquier Usuario, anfitrión o red, incluyendo sin limitación, mediante el envío de virus al Sitio Web, o mediante saturación, envíos masivos ("flooding"), "spamming", bombardeo de correo o bloqueos del sistema ("crashing"), (d) enviar correos no pedidos, incluyendo promociones y/o publicidad de productos o servicios, o (e) falsificar cualquier cabecera de paquete TCP/IP o cualquier parte de la información de la cabecera de cualquier correo electrónico o en mensajes de foros de debate.</span></p>\r\n<p class="p2"><span class="s1">Las violaciones de la seguridad del sistema o de la red pueden resultar en responsabilidades civiles o penales. DRIDCO investigará los casos en los que hubiera podido producirse tales violaciones y puede dirigirse a y cooperar con la autoridad competente para perseguir a los usuarios involucrados en tales violaciones.</span></p>\r\n<p class="p2"><span class="s1"><strong>2.5. Usos  prohibidos</strong></span></p>\r\n<p class="p2"><span class="s1">El Sitio Web sólo puede ser utilizado con propósitos legales por personas que estén buscando empleo e información referida a carreras profesionales y por empresas que busquen empleados. DRIDCO prohíbe específicamente cualquier uso del Sitio Web, y todos los Usuarios aceptan no utilizar el Sitio Web, para lo siguiente:</span></p>\r\n<p class="p2"><span class="s1">    * Anunciar datos biográficos incompletos, falsos o inexactos o datos que no correspondan con su auténtico curriculum personal (de una persona física viva que busca empleo para sí misma).</span></p>\r\n<p class="p2"><span class="s1">    * Registrar más de una cuenta correspondiente a un mismo usuario (persona física) con mismo D.N.I.</span></p>\r\n<p class="p2"><span class="s1">    * Anunciar cualquier franquicia, "Búsqueda de socios", agencias de representantes de distribución o ventas u otra oportunidad de negocio que requiera un desembolso inicial o un pago periódico por parte del empleado o que sólo retribuya comisiones (no un salario razonable), o exija el reclutamiento de otros socios, subdistribuidores o subagentes.</span></p>\r\n<p class="p2"><span class="s1">    * Borrar o revisar cualquier material anunciado por otra persona o entidad.</span></p>\r\n<p class="p2"><span class="s1">    * Usar cualquier mecanismo, software o rutina para impedir o intentar impedir el adecuado funcionamiento de este Sitio Web o cualquier actividad que se esté realizando en este Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">    * Realizar cualquier acción que imponga una carga desproporcionada o desmesurada sobre la infraestructura de este Sitio de la Web.</span></p>\r\n<p class="p2"><span class="s1">    * Si posee una contraseña que le permite acceder a un área no pública de este Sitio Web, se prohíbe revelar o compartir su contraseña con terceras personas o usar su contraseña para cualquier propósito no autorizado.</span></p>\r\n<p class="p2"><span class="s1">    * No obstante cualquier referencia en contrario que contengan estas Condiciones Generales, el uso o intento de uso de cualquier máquina, software, herramienta, agente u otro mecanismo o artilugio (incluyendo pero no limitándose a exploradores, spiders, robots, avatars o agentes inteligentes) para navegar o buscar en este Sitio Web que sean diferentes a las máquinas de buscar o los agentes buscadores puestos a disposición por DRIDCO en este Sitio Web y diferentes de los exploradores web generalmente disponibles (ej. Netscape Navigator, Microsoft Explorer).</span></p>\r\n<p class="p2"><span class="s1">    * Intentar descifrar, descompilar u obtener el código fuente de cualquier programa de software que comprenda o constituya una parte de este Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">     * Publicar avisos que contengan datos personales (teléfono, domicilio, dirección del sitio web, correo electrónico, etc.) del oferente de empleo.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO se reserva el derecho de dar de baja cualquier anuncio publicado que no cumpla con los estándares definidos en estas Condiciones Generales o con las políticas vigentes de DRIDCO (incluídas las Condiciones Particulares de cualquier servicio provisto por DRIDCO), sin que ello genere derecho a resarcimiento alguno. Idéntico derecho le cabrá a DRIDCO para suspender o dar de baja del sistema de DRIDCO a cualquier Usuario por haber incumplido estas Condiciones Generales o  por haber incurrido a criterio de DRIDCO en conductas o actos dolosos o fraudulentos mediante el uso del Sitio Web o de los Servicios prestados por DRIDCO.</span></p>\r\n<p class="p2"><span class="s1"><strong>3. DATOS PERSONALES DEL USUARIO. REGISTRO EN EL SITIO WEB. </strong></span></p>\r\n<p class="p2"><span class="s1"><strong>3.1. Registración en el Sitio Web</strong></span></p>\r\n<p class="p2"><span class="s1">Cuando se registre en el Sitio Web, se le pedirá que aporte a DRIDCO cierta información que incluirá, entre otras, una dirección válida de correo electrónico (lo que designaremos como su "Información"). Además de los términos y condiciones que se puedan establecer más adelante por cualquier política de privacidad de este Sitio Web, Usted reconoce y acepta que DRIDCO puede revelar a terceras partes, de forma anónima, cierto conjunto de datos que estén contenidos en su solicitud de registro.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO  no revelará a terceras partes su nombre, dirección de correo electrónico o el número de teléfono sin su consentimiento previo, excepto en la medida en que sea necesario para el cumplimiento de las leyes o procedimientos legales vigentes, donde tal información sea relevante. DRIDCO se reserva el derecho de ofrecerle servicios y productos de terceros basados en las preferencias que Usted indicó al momento de registrarse o en cualquier momento posterior; tales ofertas pueden efectuarse por DRIDCO o por terceros. Por favor consulte la Política de Confidencialidad  y Cookies del Sitio Web para más detalles respecto a su Información.</span></p>\r\n<p class="p2"><span class="s1">Usted es el responsable de mantener la confidencialidad de sus datos y de su contraseña. El Usuario será responsable de todos los usos de su registro, tanto si están autorizados o no por Usted. Deberá notificar inmediatamente a DRIDCO sobre cualquier uso sin autorización de su registro o contraseña.</span></p>\r\n<p class="p2"><span class="s1"><strong>4. OBLIGACIONES DEL USUARIO.</strong></span></p>\r\n<p class="p2"><span class="s1">Como Usuario, Usted es responsable de sus propias comunicaciones y de las consecuencias de su publicación. Por el hecho de usar este Sitio Web, Usted acepta no realizar ninguna de las siguientes acciones: anunciar material con derechos de autor o cualquier otro derecho de propiedad intelectual o industrial a menos que Usted sea el propietario de estos derechos o tenga permiso del propietario de los citados derechos para anunciarlo; anunciar material que revele secretos comerciales a menos que sean de su propiedad o tenga permiso del propietario; anunciar material que infrinja los derechos de propiedad intelectual o industrial de terceros, o los derechos de confidencialidad o imagen de terceros; anunciar material que sea obsceno, difamatorio, amenazador, acosador, injurioso o denigrante hacia otro Usuario, o hacia cualquier persona o entidad; anunciar una imagen o declaración sexualmente explícita; anunciar propaganda o propuestas de negocio, anunciar cartas en cadena; suplantar a otra persona; o enviar material que contenga virus, caballos de Troya, gusanos ("worms"), bombas de tiempo, "cancelbots" u otras rutinas de programación que tengan por objeto dañar, interferir negativamente, interceptar secretamente, o apropiarse de cualquier sistema, datos o información.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO no afirma ni garantiza la licitud, exactitud o fiabilidad de las comunicaciones que anuncian los Usuarios ni respalda cualquier opinión expresada por los Usuarios. El Usuario acepta implícitamente que, al confiar en los contenidos o los datos anunciados por otros Usuarios, lo hace bajo su propia responsabilidad.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO actúa como un mero conductor pasivo para la distribución y publicación on-line de la información remitida por el Usuario y no está obligada a censurar las comunicaciones o datos con carácter previo, y no tiene la obligación ni se responsabiliza de revisar o censurar el material una vez que haya sido anunciado éste por los Usuarios.</span></p>\r\n<p class="p2"><span class="s1">En caso que un Usuario le notifique la existencia de comunicaciones que presuntamente no cumplan estas Condiciones Generales, DRIDCO se reserva el derecho de investigar y determinar de buena fe y, a su exclusiva discreción, el derecho de retirar o solicitar que sean retiradas dichas comunicaciones.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO no tiene responsabilidad u obligación hacia los Usuarios de realizar o no tales actividades de control. DRIDCO se reserva el derecho de impedir el acceso de los Usuarios al Sitio Web por violar las Condiciones Generales o la ley o las Condiciones Particulares, y se reserva el derecho de suprimir comunicaciones que sean injuriosas, ilegales o contrarias a la buena moral y costumbres. DRIDCO, a su sola discreción, puede tomar las medidas que considere necesarias o convenientes respecto a los datos remitidos por Usuarios, si estima que pueden hacer incurrir a DRIDCO en responsabilidades o pueden provocar que DRIDCO pierda (total o parcialmente) los servicios de sus ISPs u otros proveedores.</span></p>\r\n<p class="p2"><span class="s1">Al remitir un contenido a cualquier área pública o no del Sitio Web, incluyendo tablones de anuncios, foros, salas de discusión y chats, el Usuario concede a DRIDCO  y a sus empresas vinculadas  el derecho gratuito, perpetuo, irrevocable, cedible (a cualquier tercero) y no exclusivo, (incluyendo todos los derechos morales), y la licencia para usar, reproducir, modificar, adaptar, publicar, traducir, distribuir, comunicar al público, representar o exhibir tal contenido (total o parcialmente) a escala mundial, así como el derecho a incorporarlo a otros trabajos en cualquier formato, medio de difusión, o soporte tecnológico existente o de desarrollo futuro, durante todo el plazo de vigencia de los derechos que puedan existir sobre tal contenido. Usted también garantiza que el propietario de cualesquiera derechos en dicho contenido, incluidos los derechos morales, ha renunciado completa y efectivamente a tales derechos y le ha concedido válida e irrevocablemente a Usted el derecho de ceder la licencia arriba citada así como el derecho a autorizar todos los usos mencionados. Asimismo, Usted permite a cualquier otro Usuario a acceder, exhibir, examinar, almacenar y reproducir tal contenido para su uso personal. Sujeto a las condiciones previstas anteriormente, el propietario de tal contenido colocado en el Sitio Web retiene todos y cada uno de los derechos que pudieran existir sobre ese contenido.</span></p>\r\n<p class="p2"><span class="s1"><strong>5. UTILIZACIÓN DEL SITIO WEB, DE LOS SERVICIOS Y DE LOS CONTENIDOS BAJO LA EXCLUSIVA RESPONSABILIDAD DEL USUARIO.</strong></span></p>\r\n<p class="p2"><span class="s1">El Usuario acepta voluntariamente que el uso del Sitio Web, de sus servicios y de los Contenidos tiene lugar, en todo caso, bajo su única y exclusiva responsabilidad.</span></p>\r\n<p class="p2"><span class="s1"><strong>6. EXCLUSIÓN DE GARANTÍAS Y DE RESPONSABILIDAD.</strong></span></p>\r\n<p class="p2"><span class="s1">El Sitio Web es exclusivamente un lugar de encuentro. El Sitio Web actúa como un punto de reunión entre instituciones educativas que anuncian ofertas y usuarios que buscan información y no investiga ni censura las ofertas. DRIDCO no interviene en la transacción entre las instituciones educativas y los usuarios. Por ello, DRIDCO carece de control sobre la calidad, seguridad o legalidad de las ofertas educativas que se anuncian, sobre la veracidad de las ofertas.</span></p>\r\n<p class="p2"><span class="s1">Asimismo, se advierte sobre cualquier riesgo, incluidos a título enunciativo, el de daño físico, de tratar con extraños, con personas de nacionalidad extranjera, con personas menores de edad o con personas que actúan fraudulentamente. El Usuario asume todos los riesgos asociados con el trato con otros Usuarios con los que entre en contacto a través del Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Debido a las dificultades en Internet para comprobar la autenticidad del Usuario, el Sitio Web no puede confirmar que cada Usuario es quien dice ser. Como no podemos intervenir en las relaciones entre Usuarios ni controlar el comportamiento de los participantes en el Sitio Web, en el caso de que Usted tenga un enfrentamiento con uno o más Usuarios, usted exonera a DRIDCO y a todas las sociedades vinculadas y asociadas (y a sus directores, representantes y empleados) de cualquier responsabilidad derivada de acciones, demandas o indemnizaciones por daños de cualquier clase o naturaleza, que sean resultado de, o tengan conexión alguna con, dichos enfrentamientos.</span></p>\r\n<p class="p2"><span class="s1">No se controla la información suministrada por otros Usuarios que se pone a su disposición en este Sitio Web. Por su propia naturaleza, la información de otras personas puede ser de índole ofensiva, perjudicial o inexacta, y en algunos casos puede estar mal identificada o identificada fraudulentamente. Le recomendamos que tenga precaución y sentido común cuando use este Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">El Contenido puede contener imprecisiones o errores tipográficos. DRIDCO no asume compromisos respecto a la exactitud, la veracidad, la exhaustividad o la actualidad del Sitio Web o del Contenido. Los riesgos del uso del Sitio Web y del Contenido  corren por exclusiva cuenta y riesgo de Usted. Los cambios en el Sitio Web se harán de forma periódica y en cualquier momento.</span></p>\r\n<p class="p2"><span class="s1">El Usuario admite y acepta que es el único responsable de la forma, el contenido y la exactitud de cualquier curriculum que coloque en el Sitio Web. Los empleadores son los únicos responsables de sus anuncios en el Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">En ningún supuesto, DRIDCO puede considerarse oferente de empleo en relación con el uso que Usted haga del Sitio Web. Ni DRIDCO ni ninguna sociedad vinculada, será responsable de ninguna decisión de selección, cualquiera que sea la razón que la fundamente, hecha por cualquier entidad que ofrezca empleo en el Sito Web.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO no garantiza la disponibilidad y continuidad del funcionamiento del Sitio Web y de los servicios ofrecidos. No todos los servicios y Contenidos en general se encuentran disponibles para todas las áreas geográficas. Asimismo, DRIDCO no garantiza la utilidad del Sitio Web y de los Servicios para la realización de ninguna actividad en particular, ni su infalibilidad y, en particular, aunque no de modo exclusivo, que los Usuarios puedan efectivamente utilizar el Sitio Web, acceder a las distintas páginas web que forman el Sitio Web o a aquéllas desde las que se prestan los Servicios.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO no garantiza la privacidad y seguridad de la utilización del Sitio Web y de los Servicios y, en particular, no garantiza que terceros no autorizados no puedan tener conocimiento de la clase, condiciones, características y circunstancias del uso que los Usuarios hacen del Sitio Web, de los Contenidos y de los Servicios.</span></p>\r\n<p class="p2"><span class="s1">Ni DRIDCO ni ninguna de las sociedades vinculadas garantizan que el Sitio Web funcionará libre de errores o que el Sitio Web y su servidor estén libres de los virus informáticos u otros mecanismos lesivos. Si por el uso del Sitio Web tiene que acudir al servicio técnico o reponer el equipo o datos, ni DRIDCO ni ninguna de las sociedades vinculadas será responsable de estos gastos.</span></p>\r\n<p class="p2"><span class="s1">El Sitio Web y el Contenido se suministran tal como están, sin garantías de ninguna clase. Ni DRIDCO ni ninguna de las sociedades vinculadas asumen ningún tipo de garantía, tanto explícita como implícita, incluyendo la garantía de aptitud para el comercio, aptitud para propósitos concretos y de no infracción de derechos de terceros, todo ello con la mayor amplitud legal.</span></p>\r\n<p class="p2"><span class="s1">Ni DRIDCO ni ninguna de las sociedades vinculadas asumen garantías sobre la exactitud, la veracidad, la exhaustividad o la actualización de los contenidos, los servicios, el software, los textos, los gráficos y los vínculos.</span></p>\r\n<p class="p2"><span class="s1">En ningún caso DRIDCO, las sociedades vinculadas, sus proveedores o terceros mencionados en el Sitio Web serán responsables de cualquier daño incluyendo pero no limitándose a, daños incidentales y derivados, lucro cesante, o daños resultantes de la pérdida de datos o interrupción del negocio, que resulten del uso o de la imposibilidad de uso del Sitio Web y del material, tanto si se fundamentan en una supuesta garantía, responsabilidad contractual o extracontractual, o cualquier otro argumento legal, independientemente de que DRIDCO, las sociedades vinculadas, sus proveedores o terceros hayan sido advertidos o no de la posibilidad de tales daños.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO excluye cualquier responsabilidad por los daños y perjuicios de toda naturaleza que puedan deberse a la falta de disponibilidad o de continuidad del funcionamiento del Sitio Web y de los Servicios, a la defraudación de la utilidad que los Usuarios hubieren podido atribuir al Sitio Web y a los Servicios, a la falibilidad del Sitio Web y de los Servicios, y en particular, aunque no de modo exclusivo, a los fallos en el acceso a las distintas páginas web del Sitio Web o a aquéllas desde las que se prestan los Servicios.</span></p>\r\n<p class="p2"><span class="s1">DRIDCO excluye toda responsabilidad por los daños y perjuicios de toda naturaleza que pudieran deberse al conocimiento que puedan tener terceros no autorizados de la clase, condiciones, características y circunstancias del uso que los Usuarios hacen del Sitio Web, de los Contenidos y de los Servicios.</span></p>\r\n<p class="p2"><span class="s1"><strong>7. VÍNCULOS A OTROS SITIOS.</strong></span></p>\r\n<p class="p2"><span class="s1">El Sitio Web contiene vínculos a otros sitios de la web. Estos vínculos los proporciona DRIDCO únicamente para su comodidad y no significan un respaldo a los contenidos de estos sitios web. DRIDCO no es responsable del contenido de los sitios web vinculados de terceros y no hace ninguna afirmación relativa al contenido o su exactitud en estos sitios web de terceros. Si Usted decide acceder a sitios web de terceras partes vinculados, lo hace a su propio riesgo.</span></p>\r\n<p class="p2"><span class="s1">El Sitio Web adoptará las medidas o procedimientos oportunos para suprimir o inutilizar aquellos enlaces de los que tenga un conocimiento efectivo de que la actividad o información a la que remiten o recomiendan es ilícita o lesiona bienes o derechos de terceros susceptibles de indemnización.</span></p>\r\n<p class="p2"><span class="s1"><strong>8. CESIÓN O USO COMERCIAL NO AUTORIZADO.</strong></span></p>\r\n<p class="p2"><span class="s1">Usted acepta no ceder, bajo ningún título, sus derechos u obligaciones bajo estas Condiciones Generales. Usted también acepta no realizar ningún uso comercial no autorizado del Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Asimismo, el Usuario se compromete a utilizar el Sitio Web, el Contenido y los Servicios de conformidad con la ley, estas Condiciones Generales y –en su caso– las Condiciones Particulares, así como de forma correcta y diligente.</span></p>\r\n<p class="p2"><span class="s1"><strong>9.  CANCELACIÓN.</strong></span></p>\r\n<p class="p2"><span class="s1">DRIDCO se reserva el derecho, a su total discreción, de emplear todos los medios legales a su alcance, -incluyendo pero no limitándose a la supresión de sus anuncios de este Sitio Web y a la inmediata cancelación de su registro, imposibilitándole el acceso al Sitio Web y/o cualquier otro servicio que le haya proporcionado a DRIDCO-, en caso que Usted infrinja cualquiera de estas Condiciones Generales o si DRIDCO es incapaz de verificar la autenticidad de cualquier información que Usted haya enviado al registro del Sitio Web.</span></p>\r\n<p class="p2"><span class="s1"><strong>10. INDEMNIZACIÓN.</strong></span></p>\r\n<p class="p2"><span class="s1">Usted acepta defender, indemnizar y mantener indemnes a DRIDCO, las sociedades vinculadas, sus directivos, empleados y representantes, de y contra cualquier cargo, acción o demanda, incluyendo, pero no limitándose a, los gastos legales razonable, que resulten del uso que Usted haga del Sitio Web, de los Contenidos y de los Servicios, o bien de la infracción por su parte de estas Condiciones Generales y, en su caso, de las Condiciones Particulares. DRIDCO le notificará puntualmente de cualquier demanda, acción o proceso y le asistirá, a su costa, en su defensa contra cualquier demanda, acción o proceso de esta naturaleza.</span></p>\r\n<p class="p2"><span class="s1"><strong>11. GENERAL.</strong></span></p>\r\n<p class="p2"><span class="s1">DRIDCO no asegura que los Contenidos puedan ser visualizados o descargados legítimamente fuera de Argentina. El acceso a los Contenidos por ciertas personas o en ciertos países puede ser ilegal. Si Usted accede al Sitio Web fuera de Argentina, lo hace bajo su propia responsabilidad y es responsable de cumplir las leyes de su jurisdicción.</span></p>\r\n<p class="p2"><span class="s1">Estas Condiciones Generales se rigen por las leyes de la Republica Argentina. Cualesquiera demanda derivada de estas Condiciones Generales se someterá exclusivamente a la jurisdicción de los juzgados y tribunales de la Ciudad de Buenos Aires (Argentina), salvo que por imperativo legal sean competentes los juzgados y tribunales del domicilio del Usuario, en cuyo caso prevalecerá este fuero. Si cualquier cláusula de estas Condiciones Generales se declarase nula por cualquier órgano jurisdiccional competente, la nulidad de tal cláusula no afectará a la validez de las restantes cláusulas de estas Condiciones Generales, que mantendrán su plena vigencia y efecto. Ninguna renuncia a cualquier cláusula contenida en estas Condiciones Generales será considerada como una renuncia continuada de dicha cláusula o cualquier otra cláusula.</span></p>\r\n<p class="p2"><span class="s1">Con la excepción de las estipulaciones adicionales que se expliciten en otras áreas del Sitio Web, de determinadas "Advertencias legales", de las Licencias del Software o material en determinadas páginas web, o de las Condiciones Particulares que Usted haya acordado con DRIDCO, estas Condiciones Generales constituyen la totalidad del acuerdo entre usted y DRIDCO con respecto al uso del Sitio Web. Cualquier cambio de estas Condiciones Generales requiere la colocación de un texto revisado en esta página web.</span></p>\r\n<p class="p2"><span class="s1"><strong>12. DURACIÓN Y TERMINACIÓN.</strong></span></p>\r\n<p class="p2"><span class="s1">La prestación del servicio de Sitio Web y de los demás Contenidos y Servicios tiene, en principio, una duración indefinida. No obstante ello, DRIDCO está autorizada para dar por terminada o suspender la prestación del servicio del Sitio Web y/o de cualquiera de los Contenidos y Servicios en cualquier momento, sin perjuicio de lo que se hubiere dispuesto al respecto en las correspondientes Condiciones Particulares. Cuando ello sea razonablemente posible, DRIDCO comunicará previamente la terminación o suspensión de la prestación del servicio del Sitio Web y de los demás Servicios.</span></p>\r\n<p class="p2"><span class="s1"><strong>13. TÉRMINOS DE USO ADICIONALES.</strong></span></p>\r\n<p class="p2"><span class="s1">Ciertas áreas de este Sitio Web están sujetas a términos y condiciones de uso adicionales. Al usar estas áreas, o cualquier parte de ellas, Usted acepta cumplir los términos adicionales aplicables a dichas áreas.</span></p>\r\n<p class="p3"><span class="s1">Condiciones Generales actualizados al _______________</span></p>\r\n<p class="p4"><span class="s1">COMPROMISO DE PRIVACIDAD</span></p>\r\n<p class="p2"><span class="s1"><strong>Aspectos generales</strong></span></p>\r\n<p class="p2"><span class="s1">El Compromiso de Privacidad del Sitio Web <a href="http://www.expozonajobs.com"><span class="s3">__________________</span></a> se regirá por el establecido para el Sitio <a href="http://www.zonajobs.com"><span class="s3">___________________</span></a>, que a continuación se transcribe.</span></p>\r\n<p class="p2"><span class="s1">El sitio web ______________ (el “Sitio Web”) es operado por DRIDCO S.A. según se describe a continuación.</span></p>\r\n<p class="p2"><span class="s1">Dridco se compromete a proteger la privacidad de los usuarios del Sitio Web. Se procura ofrecer a los usuarios una experiencia on-line segura y con garantías. El objetivo del presente Compromiso es informar a los usuarios cómo utilizaremos los datos personales que nos facilite a través de este Sitio Web, sin que sea aplicable a información que obtengamos de cualquier otro modo. Este Compromiso se dirige a demandantes de empleo y empresas.</span></p>\r\n<p class="p2"><span class="s1">Dridco cumple la legislación sobre protección de datos. Esa legislación regula el tratamiento de información relativa a usted y le concede diversos derechos respecto de sus datos personales.</span></p>\r\n<p class="p2"><span class="s1">El Sitio Web contiene enlaces a otros sitios web sobre los que Dridco no tiene ningún control. Dridco no es responsable de las políticas o prácticas sobre privacidad de otros sitios web con los que usted elija enlazarse desde el Sitio Web. Le recomendamos que revise las políticas de privacidad de esos otros sitios web para que pueda ponerse al corriente de cómo recogen, usan y comparten sus datos. Este Compromiso de Privacidad se aplica exclusivamente a la información que Dridco obtenga en este el Sitio Web, sin que sea aplicable a información que Dridco obtenga de cualquier otro modo.</span></p>\r\n<p class="p2"><span class="s1"><strong>Obtención y retención de información</strong></span></p>\r\n<p class="p2"><span class="s1">Usted no tiene que darnos ninguna información personal con objeto de realizar búsquedas de empleo.</span></p>\r\n<p class="p2"><span class="s1">En algunas áreas del Sitio Web, Dridco requiere que usted facilite datos personales, incluido su nombre, dirección, dirección de correo electrónico, número de teléfono, información de contacto, información para facturación y otros datos de los que se pueda deducir su identidad. En otras áreas del Sitio Web, Dridco recoge o puede recoger información demográfica que no es exclusiva de usted, como su código postal, edad, género y los tipos de empleo en que esté interesado. En ocasiones Dridco recoge o se puede recoger una combinación de los dos tipos de información.</span></p>\r\n<p class="p2"><span class="s1">Además, Dridco podrá recoger indirectamente información sobre usted cuando use ciertos servicios de terceros en el Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Asimismo, Dridco obtiene o puede obtener cierta información personal sobre el uso que hace del Sitio Web, como por ejemplo a qué páginas accede y qué servicios utiliza. Además, hay información sobre el hardware y software de su computadora que es o puede ser recogida por Dridco. Esta información puede incluir su dirección IP, tipo de navegador, nombres de dominio, horas de acceso y referencias a direcciones de sitios web, si bien esta información no queda vinculada a sus datos personales.</span></p>\r\n<p class="p2"><span class="s1">En ocasiones Dridco puede ofrecer al usuario la oportunidad de dar sobre sí mismo información descriptiva, cultural o de su conducta, preferencias y/o estilo de vida, pero depende exclusivamente de usted que aporte esa información. Si da esa información, consiente con ello al uso de la misma de acuerdo con las políticas y prácticas descritas en este Compromiso de Privacidad. Por ejemplo, esa información podrá ser usada a efectos de determinar su interés potencial en recibir correo electrónico u otras comunicaciones sobre determinados productos o servicios.</span></p>\r\n<p class="p2"><span class="s1"><strong>Divulgación en áreas públicas de Dridco</strong></span></p>\r\n<p class="p2"><span class="s1">Recuerde que si divulga cualquiera de sus datos personales en áreas públicas del Sitio Web, como la base de datos de Curriculum con acceso en búsquedas, esa información podrá ser examinada y usada por otros sobre los que Dridco no tiene control alguno. No somos responsables del uso por terceras personas de información que usted difunda o haga disponible de otra forma en áreas públicas de Dridco.</span></p>\r\n<p class="p2"><span class="s1"><strong>Uso de sus datos por Dridco</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco utiliza los datos que obtiene en el Sitio Web, ya sean personales, demográficos, colectivos o técnicos, para los fines de administrar y gestionar su registro, responder a cualesquiera consultas que usted haga, operar y mejorar el Sitio Web y entregar los productos y servicios que ofrece Dridco a demandantes de empleo y empresas.</span></p>\r\n<p class="p2"><span class="s1">Si usted así lo ha aceptado al registrarse en el Sitio Web o posteriormente, o si es permitido por las leyes aplicables, podemos usar su información de contacto para enviarle correo electrónico u otras comunicaciones relativas a actualizaciones en el Sitio Web. Además, en el momento del registro usted tiene la opción de elegir la recepción de comunicaciones, información y promociones adicionales, relativas a temas que puedan ser de especial interés para usted. Si ha dado su consentimiento o si es permitido por las leyes aplicables, también podemos usar la información que obtengamos para informarle de otros productos o servicios disponibles en el Sitio Web  o para ponernos en contacto con usted con el fin de recabar su opinión sobre productos y servicios actuales o nuevos productos y servicios potenciales que le puedan ser ofrecidos.</span></p>\r\n<p class="p2"><span class="s1">En el Sitio Web existe un área donde usted puede ponerse en contacto con Dridco y remitir sus comentarios. Dridco podrá utilizar esos comentarios (como una experiencia exitosa) para fines de promoción o para ponernos en contacto con usted con objeto de obtener información adicional.</span></p>\r\n<p class="p2"><span class="s1"><strong>Revelación de información a terceros</strong></span></p>\r\n<p class="p2"><span class="s1">No revelamos a terceros sus datos personales, información personal y demográfica combinada o información sobre su uso del Sitio web (como las áreas que visita o los servicios a los que accede), excepto en los supuestos siguientes.</span></p>\r\n<p class="p2"><span class="s1">1. Podemos revelar esa información a terceros si usted da su consentimiento.</span></p>\r\n<p class="p2"><span class="s1">2. Podemos revelar esa información a empresas y personas físicas que empleemos para desempeñar funciones en nuestro nombre. Las funciones desempeñadas en nuestro nombre incluyen hosting en nuestros servidores de red, análisis de datos, prestación de asistencia de marketing, procesamiento de pagos por tarjeta de crédito y prestación de servicios a clientes. Estas empresas y personas tendrán acceso a sus datos personales en la medida que sea necesaria para desempeñar sus funciones, pero no podrán compartir esa información con ningún tercero o usar esos datos para ningún otro objeto. Nosotros retendremos el control de cualquier información compartida de esta forma y seremos responsables de dicha información.</span></p>\r\n<p class="p2"><span class="s1">3. Podemos revelar esa información si fuera legalmente requerido hacerlo, si fuera solicitado por una entidad oficial o autoridad reguladora o si estimamos de buena fe que esa acción es necesaria para: (a) ajustarnos a requisitos legales o cumplir un proceso legal; (b) proteger los derechos o bienes de Dridco o de sus sociedades vinculadas; (c) prevenir un delito o proteger la seguridad nacional, o (d) proteger la seguridad personal de los usuarios o del público.</span></p>\r\n<p class="p2"><span class="s1">4. Podemos revelar y transmitir esa información a un tercero que adquiera la totalidad o una parte sustancial del negocio de Dridco, independientemente de que dicha adquisición sea por vía de fusión, consolidación o compra de la totalidad o una parte sustancial de sus activos. Además, en el caso de que Dridco sea objeto de un procedimiento de insolvencia, voluntario o involuntario, Dridco o su liquidador, administrador, interventor o interventor administrativo podrá vender, conceder licencia al respecto o disponer de otro modo de esa información en una operación aprobada por un tribunal. Será usted informado de la venta de la totalidad o una parte sustancial de nuestro negocio a un tercero por medio del correo electrónico o a través de un anuncio destacado publicado en el sitio de Dridco.</span></p>\r\n<p class="p2"><span class="s1"><strong>Otros usos de información</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco también podrá compartir información anónima colectiva sobre visitantes al Sitio Web con sus clientes, socios y otras terceras partes a fin de que puedan estar al corriente de las clases de visitantes del sitio de Dridco y de cómo esos visitantes usan el sitio.</span></p>\r\n<p class="p2"><span class="s1">Curriculums y sus datos personales serán almacenados y procesados en ordenadores situados en los Estados Unidos según más abajo se describe. Por otro lado, algunas de las empresas o agencias de empleo que se interesen por su Curriculum podrán estar situadas en cualquier país del mundo. Esos países podrán no tener una legislación equivalente sobre protección de datos que proteja el uso de sus datos personales. No enviaremos sus datos personales a empresas de dichos países a menos que usted haya indicado que desea que se acceda a su Curriculum mediante búsquedas (Privacidad: Público). Mediante esta indicación, usted da su consentimiento expreso a que se realicen esas transferencias de datos.</span></p>\r\n<p class="p2"><span class="s1"><strong>Uso de web beacons</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco pueden contener imágenes electrónicas conocidas como "web beacons" (algunas veces denominadas "single-pixel gifs") que nos permiten contar los usuarios que han visitado el Sitio Web. Los web beacons no se usan para acceder a su información personal identificable que se almacena en Dridco; constituyen una técnica que usamos para confeccionar estadísticas de forma colectiva sobre el uso de nuestro Sitio Web.</span></p>\r\n<p class="p2"><span class="s1">Los web beacons recogen solamente un conjunto limitado de datos, incluido un número de cookie, la hora y fecha de visita a un sitio y una descripción del sitio en que reside el web beacon.</span></p>\r\n<p class="p2"><span class="s1">Dado que los web beacons son como cualquier otra petición de contenidos incluidos en una página, usted no puede desactivarlos o rechazarlos. Sin embargo, puede hacer que no sean efectivos desactivando las cookies o cambiando la configuración de cookies en su navegador.</span></p>\r\n<p class="p2"><span class="s1"><strong>Actualización o supresión de sus datos</strong></span></p>\r\n<p class="p2"><span class="s1">Usted puede revisar, corregir, actualizar o cambiar sus datos personales de la cuenta de Registro o su Curriculum en cualquier momento. Simplemente acceda a su cuenta de Registro, vaya a su perfil de la cuenta o su Curriculum, revise sus datos de la cuenta o Curriculum y, si lo desea, edítelos con las opciones que se facilitan. También podrá suprimir su Curriculum mediante este método.</span></p>\r\n<p class="p2"><span class="s1">Si en cualquier momento desea suprimir su información de datos personales de la cuenta de Registro, póngase en contacto con Dridco a través del formulario “Contactanos” al cual se puede acceder desde el link situados en el margen superior derecho de todas las páginas disponibles en el sitio.</span></p>\r\n<p class="p2"><span class="s1">Si desea revocar su consentimiento a nuestro Compromiso de Privacidad, póngase en contacto con nosotros a través del formulario “Contactanos” al cual se puede acceder desde el link situados en el margen superior derecho de todas las páginas disponibles en el sitio. Sin embargo, tenga en cuenta que si retira su consentimiento, no podrá usar los servicios correspondientes y serán suprimidos sus datos personales de la cuenta de registro de Dridco.</span></p>\r\n<p class="p2"><span class="s1">Si optó por recibir Newsletters, correos electrónicos comerciales u otras comunicaciones de Dridco o de terceras partes en el momento de registrarse, pero posteriormente cambia de opinión, podrá anular su opción editando su perfil de cuenta según lo arriba descrito. Si previamente optó por no recibir esas comunicaciones, podrá posteriormente anular esa opción editando su perfil de cuenta.</span></p>\r\n<p class="p2"><span class="s1">Como creemos que gestionar su promoción profesional es un proceso que dura toda la vida, conservamos toda la información que recabamos sobre usted con el fin de que el uso repetido de nuestros servicios se produzca de forma eficiente, práctica y relevante hasta que cambie o retire sus datos personales según lo arriba indicado anteriormente. Si es usted un demandante de empleo y no ha accedido al sitio web durante 9 meses, automáticamente hacemos que su Curriculum no sea accesible en búsquedas. Por supuesto, puede corregir o actualizar su perfil y su Curriculum en cualquier momento. Además, puede suprimir su Curriculum de la base de datos on-line de Dridco cuando lo desee. Si lo hace, retiraremos todas nuestras copias de su Curriculum.</span></p>\r\n<p class="p2"><span class="s1"><strong>Seguridad</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco ha implementado medidas apropiadas de carácter técnico y organizativo que están diseñadas para garantizar la seguridad de su información personal frente a pérdidas accidentales y frente al acceso, uso, alteración o divulgación no autorizados. En particular, todos los datos de la cuenta y de la clave de acceso están encriptados (es decir, se codifican entre su computadora y los servidores de Dridco). Pese a estas medidas, Internet es un sistema abierto y no podemos garantizar que terceras partes no autorizadas nunca podrán romper estas medidas o usar su información personal para fines indebidos.</span></p>\r\n<p class="p2"><span class="s1"><strong>Menores de edad</strong></span></p>\r\n<p class="p2"><span class="s1">Dridco no está dirigido a personas menores de 18 años de edad, salvo en aquellos supuestos en donde la legislación aplicable así lo permita.</span></p>\r\n<p class="p2"><span class="s1"><strong>Cambios en el Compromiso de Privacidad</strong></span></p>\r\n<p class="p2"><span class="s1">Usted podrá consultar en cualquier momento nuestro Compromiso de Privacidad. Si en cualquier momento tiene preguntas o dudas sobre el Compromiso de Privacidad de Dridco, no dude en contactarse a través del formulario “Contáctenos” al cual se puede acceder desde el link situados en el margen superior derecho de todas las páginas disponibles en el sitio.</span></p>\r\n<p class="p3"><span class="s1">Compromiso de Privacidad actualizado al ___________</span></p>', '', NULL, '2013-01-14 19:45:29', 1, 'backend', '2013-02-17 18:21:35', 1, 'backend', '2013-02-17 18:22:08', 1, 1, 1, 0, 'a:3:{s:9:"metatitle";s:33:"Términos y condiciones Argentina";s:15:"metadescription";s:0:"";s:4:"tags";s:0:"";}');
INSERT INTO `object` VALUES(172, 1, 0, 'Estudiar posgrados, necesidad laboral', 'estudiar-posgrados-necesidad-laboral', '<p class="p1"><span class="s1"><strong>CIUDAD DE MÉXICO (CNNExpansión.com) — </strong></span><span class="s2">Para Tania Vitela Hernández estudiar la licenciatura en comunicación "no fue suficiente", y con el fin de adquirir conocimientos más concretos de un área, que pudiera aplicar en su desempeño, estudió una maestría.</span></p>\r\n<p class="p2"><span class="s2">"Ya tenía un puesto laboral, pero necesitaba generar un valor agregado y sentí que a través de esta alternativa lo conseguiría. Además hay carreras donde sientes que te enseñan de todo y, a la vez, ‘nada'', así que este recurso permite especializarte, y lo puedes ir desarrollando mientras trabajas", expresa.</span></p>\r\n<p class="p2"><span class="s2">Cursar un postgrado es un <em>plus </em>en el currículo, pues "actualmente los mejores puestos son para quienes estén actualizados, alertas al cambio y con la capacidad de aplicar nuevas técnicas ante escenarios reales", indica David García Junco, director de Educación Continua de la Universidad Iberoamericana (UIA).</span></p>\r\n<p class="p2"><span class="s3"><a href="http://www.cnnexpansion.com/especiales/los-mejores-mba-2009">La maestría y el doctorado, menciona, llaman la atención de los reclutadores</a></span><span class="s2"> porque simbolizan un esfuerzo adicional por parte de un candidato. La persona puede, a través de esta herramienta, profundizar en conocimientos apreciados en el mercado laboral, entre estos, la resolución práctica de problemas que se presentan en diversos rubros de la empresa.</span></p>\r\n<p class="p2"><span class="s2">El precio que los aspirantes deben cubrir por estudiar en alguna institución privada supera los 20,000 pesos, por semestre (tales cifras varían en caso de universidades públicas); ese fue el caso de Tania, quien debió pagar alrededor de 25,000 mensuales en la Universidad Anáhuac del Sur.</span></p>\r\n<p class="p2"><span class="s2">Sin embargo, "el retorno de esta inversión medido en incremento del salario al obtener el grado puede superar hasta un 60%, según la base salarial que se tenía al iniciar estos estudios y la especialización", indica el representante de la UIA.</span></p>\r\n<p class="p2"><span class="s2">Leer estas cifras seguro "te mueve el tapete", pero antes de tomar la decisión de especializarte debes reflexionar en ciertos puntos que, si bien parecen insignificantes, son valiosos al momento de elegir un posgrado, como: tiempo de traslados, horarios de estudio y costos, comenta Carlos Cienfuegos, director de posgrados de la Universidad Tecnológica de México (UNITEC).</span></p>\r\n<p class="p2"><span class="s2">"Si la persona trabaja, tiene que demostrar a sus superiores las ventajas de cursar un estudio de este tipo. Lo que el jefe quiere saber es qué recibirá a cambio del tiempo que otorgará a la persona. En otras palabras: tipo de habilidades que aportará a la organización, adicionales a aquéllas por las que fue contratada", explica Cienfuegos.</span></p>\r\n<p class="p2"><span class="s2"><strong>¿Local o extranjera?</strong></span></p>\r\n<p class="p2"><span class="s2">Realizar una maestría o doctorado en México permite "estudiar y trabajar al mismo tiempo. Así la persona no pierde sus contactos laborales sino que los fortalece porque aplica los conocimientos adquiridos de forma inmediata", explica Jorge Ledesma, director de la División de Posgrados de la Escuela Bancaria Comercial (EBC).</span></p>\r\n<p class="p2"><span class="s2">Agrega que otro beneficio es el costo, pues aunque los posgrados no son tan económicos, el estudiante no debe financiar una estancia como sucede cuando sale al extranjero.</span></p>\r\n<p class="p2"><span class="s2">"Aunque se tenga cierta beca la persona termina por destinar parte de su dinero para manutención, entre otros gastos", dice.</span></p>\r\n<p class="p2"><span class="s2">El director de la División de Negocios y Posgrados del Tecnológico de Monterrey, campus Santa Fe, Mario De Marchis, asegura que elegir una institución mexicana no significa carecer de experiencia internacional.</span></p>\r\n<p class="p2"><span class="s2">Por el contrario, afirma, las universidades son concientes de que sus estudiantes necesitan conocer diversos modelos de trabado e idiomas para adecuarse a la demanda empresarial, especialmente si buscan o están desempeñándose en una compañía trasnacional.</span></p>\r\n<p class="p2"><span class="s2">"Esta inquietud por buscar la competencia internacional propicia que cada vez más instituciones incluyan la participación de profesiones extranjeros y la opción de doble titulación; esto, en conjunto con la oportunidad de llevar el aprendizaje inmediato al ámbito laboral, genera un impacto positivo para el interesado en estudiar, localmente, y no fuera del país", añade el director.</span></p>\r\n<p class="p2"><span class="s2">Si ya reflexionaste los factores mencionados y reafirmaste tu interés por cursar estudios de posgrado, estás realizando una inversión a futuro y ahora es momento de elegir el programa que responda a tus necesidades.</span></p>\r\n<p class="p2"><span class="s2">Antes de elegir el área donde especializarte, piensa en los motivos que te impulsan a decidirte por esta actividad; no lo tomes a la ligera, ya que esta decisión influirá, en gran medida, en tu futuro personal y profesional. Para mayor información sobre el tema puedes consultar páginas, como la de la Asociación Nacional de Universidades e Instituciones de Educación Superior, ANUIES: <a href="http://www.anuies.mx/"><span class="s3">www.anuies.mx</span></a></span></p>\r\n<p class="p3"> </p>\r\n<p class="p4"><span class="s2"><strong>Radiografía de la especialización</strong></span></p>\r\n<p class="p4"><span class="s2">- Los posgrados de mayor demanda (46.9%) pertenecen al área de Ciencias Sociales y Ciencias Administrativas.</span></p>\r\n<p class="p4"><span class="s2">- Los menos demandados (16%) son los de Ciencias Agropecuarias.</span></p>\r\n<p class="p4"><span class="s2">- En México, alrededor de 526 instituciones ofrecen postgrados: aproximadamente 1,183 son programas de especialización, 2,851 de maestría, y 516 doctorado.</span></p>\r\n<p class="p5"> </p>\r\n<p class="p6"> </p>\r\n<p class="p7"><span class="s1">Por: </span><span class="s4">Ivonne Vargas</span></p>\r\n<p class="p2"><span class="s2"><em>Fuente: CNNExpansión.com con datos de ANUIES.</em></span></p>', '<p class="p1"><span class="s1">Continuar los estudios se ha vuelto una necesidad ante las exigencias del mercado laboral; este tipo de preparación exige esfuerzo y tiempo, pero te abre la puerta a mejores puestos.</span></p>', '', '2013-02-18 17:45:53', 1, 'backend', '2013-03-07 15:54:45', 1, 'backend', '2013-03-07 15:55:36', 1, 1, 1, 0, 'a:3:{s:9:"metatitle";s:37:"Estudiar posgrados, necesidad laboral";s:15:"metadescription";s:204:"                  Continuar los estudios se ha vuelto una necesidad ante las exigencias del mercado laboral; este tipo de preparación exige esfuerzo y tiempo, pero te abre la puerta a mejores puest [...]";s:6:"header";s:0:"";}');
INSERT INTO `object` VALUES(171, 1, 0, 'Mayor capacitación mejora tu empleabilidad', 'mayor-capacitacion-mejora-tu-empleabilidad', '<p class="p1"><span class="s1">….aún si no terminaste tus estudios primarios o secundarios, tomate unos minutos que esta nota te puede ayudar…</span></p>\r\n<p class="p2"><span class="s1">La </span><span class="s2"><strong>empleabilidad </strong></span><span class="s1">es un concepto que hace referencia  al </span><span class="s3">potencial</span><span class="s1"> que tiene un individuo de ser solicitado por una empresa para trabajar en ella. Sería la sumatoria de sus capacidades, habilidades y formación que pueda ofrecer al mercado laboral. Es claro que cada vez que se prepare mejor, usted aumentará las posibilidades de ser elegido como mejor candidato ante un empleador.</span></p>\r\n<p class="p3"> </p>\r\n<p class="p2"><span class="s1">En esta nota en particular, me gustaría que nos centremos específicamente en la “Capacitación” como herramienta clave para mejorar nuestra empleabilidad. La capacitación/formación es la que actúa en aquellos momentos en que “alguien debe o quiere hacer algo, pero que no sabe cómo hacerlo”…siendo esta definición muy casera, lo que intento es aclarar que la capacitación no es solo “formal” (ej. a través de un instituto que le otorgue un diploma) sino que por el contrario estamos la mayor parte del tiempo capacitándonos, tal vez hasta sin darnos cuenta. Cada vez que un jefe nos retroalimenta diciendo lo que hicimos mal y cómo hacerlo bien… cuando un amigo nos enseña a usar mejor las redes sociales… cuando día a día ejecutamos un sistema y vamos ganando en el mejor manejo del mismo …estamos capacitándonos.</span></p>\r\n<p class="p2"><span class="s1">Cada profesión, tiene sus capacitaciones técnicas y específicas que contribuyen a una mejor formación profesional, pero es difícil detenernos en ello porque deberíamos armar una guía. Para aquellos que han accedido al mundo universitario, no creo que encuentren dificultades en cómo y dónde formarse, ya que disponen de un arsenal de profesores con quienes compartir inquietudes y solicitar sugerencias. Sin embargo, las dificultades en formaciones, aparecen generalmente, en aquellos que aún no han terminado sus estudios primarios o secundarios y se ven impedidos de ser capacitados porque les exigen títulos, o tal vez por cuestiones económicas o simplemente por no saber a dónde ni cómo acceder. Por ello lo que sí pretendo compartir en esta nota son algunos espacios públicos de acceso gratuito, que le pueden ayudar a mejorar  su empleabilidad y mantener una red de contactos con aquellos que se encuentran en la misma situación.</span></p>\r\n<p class="p3"> </p>\r\n<p class="p2"><span class="s1">El Ministerio de Trabajo, Empleo y Seguridad Social de la Argentina tiene actualmente dos programas vigentes que ayudan a la inserción laboral a través de la capacitación. Lo importante de saber es que ambos programas aplican a las distintas provincias de la Argentina, depende el lugar de residencia de cada uno deberá llamar a la oficina correspondiente.</span></p>\r\n<p class="p2"><span class="s1">A continuación les comparto algunos detalles para los interesados:</span></p>\r\n<p class="p4"><span class="s4"><strong>Jóvenes con Más y Mejor trabajo </strong><a href="http://www.trabajo.gov.ar/jovenes/"><span class="s5"><strong>http://www.trabajo.gov.ar/jovenes/</strong></span></a></span></p>\r\n<p class="p2"><span class="s1">Es un Programa destinado a brindar un conjunto de prestaciones integradas de apoyo a la construcción e implementación de un proyecto formativo y ocupacional para los jóvenes. El objetivo es generar oportunidades de inclusión social y laboral de los jóvenes, a través de acciones integradas, que les permitan construir el perfil profesional en el cual deseen desempeñarse, finalizar su escolaridad obligatoria, realizar experiencias de formación y prácticas calificantes en ambientes de trabajo, iniciar una actividad productiva de manera independiente o insertarse en un empleo.</span></p>\r\n<p class="p2"><span class="s1">Los requisitos que se exigen para poder participar es tener una edad entre 18 a 24 años, tener residencia permanente en el país, </span><span class="s3">no</span><span class="s1"> haber completado el nivel primario y/o secundario de escolaridad y adicionalmente que se encuentren desempleados.</span></p>\r\n<p class="p2"><span class="s1">Para los jóvenes interesados en participar del programa, deberán solicitar una entrevista en la Oficinade Empleo Municipal correspondiente a su domicilio de residencia. O comunicarse al Tel.: 0800-222-2220 (011) 4310-5854, o enviar un mail: <a href="mailto:jovenes@trabajo.gob.ar"><span class="s5">jovenes@trabajo.gob.ar</span></a>. Allí deberán presentar el DNI y la constancia de CUIL. Un orientador entrevistará a los jóvenes interesados para ampliar la información y completará o actualizará su historia laboral. Finalizado este registro, ambas partes firmarán un convenio de adhesión al programa que se remitirá, para su validación, a las Gerencias de Empleo y Capacitación Laboral del MTEySS.</span></p>\r\n<p class="p3"> </p>\r\n<p class="p4"><span class="s4"><strong>Red de servicios de empleos </strong><a href="http://www.trabajo.gov.ar/redempleo/"><span class="s5"><strong>http://www.trabajo.gov.ar/redempleo/</strong></span></a></span></p>\r\n<p class="p2"><span class="s1">Esta red garantiza la prestación de servicios de empleo, orientados a interrelacionar un conjunto de herramientas de políticas activas de empleo articulando tres ejes fundamentales: orientación laboral, calificación/formación profesional e inserción laboral.</span></p>\r\n<p class="p2"><span class="s1">Los destinatarios o potenciales usuarios serían:</span></p>\r\n<p><span class="s1">Personas con problemas de empleo: Desocupados, Subocupados, Beneficiarios de Programas, Personas que desean cambiar de empleo, entre otros</span> <span class="s1">Empleadores: empresas grandes, PYMES, Particulares, Estado, Cooperativas, etc.</span> <span class="s1"> Microemprendedores</span></p>\r\n<p class="p2"><span class="s1">En el caso de los primeros destinatarios, podrán acceder a:</span></p>\r\n<p><span class="s1"> Diferentes capacitaciones (talleres) desde transferencia de conocimientos específicos de oficios, como así también preparación para que usted pueda reconocer cuáles son sus propios recursos y cómo hacer uso de ellos.</span> <span class="s1">  Dejar su CV, junto con su historia laboral, para que la red pueda postularlo a las ofertas de empleos que se encuentren vigentes. En el caso que usted no tenga su CV armado, ellos le ayudan con el armado del mismo, dándoles un soporte y acompañamiento por medio de un especialista.</span> <span class="s1"> La disposición de un especialista que lo oriente en caso que usted quiera desarrollar un emprendimiento independiente y no sepa bien cómo hacerlo.</span> <span class="s1">  Experiencias profesionales en puestos reales sin poseer conocimientos previos, ni preparación alguna.</span></p>\r\n<p class="p6"> </p>\r\n<p class="p7"><span class="s1"><strong>Por último, les comparto 3 tips para tener en cuenta en relación a este tema:</strong></span></p>\r\n<p><span class="s1"> Cada vez que realice cualquier <strong>modificación en su perfil profesional</strong> (ej. aprenda una herramienta de sistemas, se perfeccione con un estudio, o haya desarrollado una nueva capacidad por un desafío propuesto) recuerde que debe sumarlo en su CV y luego rentabilizarlo en una entrevista de empleo. Como venimos hablando cada nueva cosa que usted sepa hacer le asegura una mayor empleabilidad y “a mayor empleabilidad, mayor posibilidad de encontrar o de tener un mejor empleo”.</span> <span class="s1"> Realice un análisis específico para identificar cuál es su perfil, con sus fortalezas y debilidades. Recuerde que lo que usted no comenta el entrevistador no puede adivinar, y el único encargado de venderse bien es usted, por lo cuál le recomiendo la siguiente nota para ejecutar esta actividad.  <a href="http://blog.zonajobs.com/postulantes/sepa-definir-su-perfil-profesional-con-sus-fortalezas-y-debilidades/?utm_source=AutoPromo&amp;utm_medium=Banner_300x250&amp;utm_campaign=AutoPromo%2B-%2BBanner_300x250%2B-%2BBlog" target="_blank">Sepa definir su perfil profesional con sus fortalezas y debilidades</a>.<br /></span><span class="s1">Reconozca quien es la persona que impide su crecimiento, para ello lo dejo con la reflexión del siguiente texto</span></p>\r\n<p class="p8"> </p>\r\n<p class="p7"><span class="s1"><strong>Murió la persona que impedía tu crecimiento</strong></span></p>\r\n<p class="p2"><span class="s1">Un día cuando los empleados llegaron a trabajar, encontraron un enorme letrero en la recepción que decía: “ayer falleció la persona que impedía el crecimiento de usted en esta empresa. Esta invitado al velatorio en el salón principal del edificio”.<br /> Al comienzo, todos se entristecieron por la muerte de unos de sus compañeros, pero después comenzaron a sentir curiosidad por saber quien era el que estaba impidiendo el crecimiento de sus compañeros y de la empresa.<br /> La agitación era tan grande en el salón principal que tuvieron que llamar a los de seguridad para organizar la fila en el velatorio.<br /> Conforme las personas iban acercándose al ataúd, la excitación aumentaba: ¿quién será que estaba impidiendo mi progreso? Qué bueno que el infeliz murió!<br /> Uno a uno los empleados agitados se aproximaban al ataúd, miraban al difunto y tragaban seco. Se quedaban unos minutos en el más absoluto silencio, como si les hubieran tocado lo más profundo del alma.<br /> Pues bien, en el fondo del ataúd había un espejo,…cada uno se veía a si mismo…</span></p>\r\n<p class="p7"><span class="s1"><strong>“Tu vida no cambia…cuando cambia tu jefe, cuando cambia tu empresa, cuando cambia tu pareja…cuando cambian los demás.</strong></span></p>\r\n<p class="p7"><span class="s1"><strong>Tu vida cambia….cuando tú cambias…y eres responsable por ella”</strong></span></p>\r\n<p class="p3"> </p>\r\n<p class="p2"><span class="s1">Atrévete a más, aumenta tu empleabilidad y mejora tus condiciones de empleo.</span></p>\r\n<p class="p2"><span class="s1">Suerte con ello!</span></p>\r\n<p class="p3"> </p>\r\n<p class="p9"><span class="s1"><strong>Por: Sofía Carrasco, <br /> Lic. En Relaciones del Trabajo<br /> </strong></span><span class="s2"><strong>Especialista en RRHH de Zona Jobs</strong></span></p>\r\n<p class="p10"><span class="s7">Fuente: </span><span class="s3"><a href="http://blog.zonajobs.com/" target="_blank">Blog ZonaJobs</a></span></p>', '<p><span>La  empleabilidad  es un concepto que hace referencia  al  potencial  que tiene un individuo de ser solicitado por una empresa para trabajar en ella. Sería la sumatoria de sus capacidades, habilidades y formación que pueda ofrecer al mercado laboral.</span></p>', '', '2013-02-18 17:42:13', 1, 'backend', '2013-03-07 15:55:26', 1, 'backend', '2013-03-07 15:55:38', 1, 1, 1, 0, 'a:3:{s:9:"metatitle";s:43:"Mayor capacitación mejora tu empleabilidad";s:15:"metadescription";s:209:"                  La  empleabilidad  es un concepto que hace referencia  al  potencial  que tiene un individuo de ser solicitado por una empresa para trabajar en ella. Sería la sumatoria de sus cap [...]";s:6:"header";s:0:"";}');
INSERT INTO `object` VALUES(170, 1, 0, '5 profesiones con mucho futuro, que ni siquiera conocías', '5-profesiones-con-mucho-futuro-que-ni-siquiera-conocias', '<p class="p1"><span class="s1">En un mundo dominado por los cambios económicos y la revolución tecnológica, tu elección vocacional es algo clave para tu futuro bienestar. ¿Tienes una vocación ya definida? ¿O aún estás en la búsqueda de algo que te entusiasme, y a la vez, te deje dinero?</span></p>\r\n<p class="p1"><span class="s1">Muchos jóvenes deciden su futuro profesional a partir de las sugerencias y los consejos de sus familias. Pero quizás no sepas que hay algunas nuevas y apasionantes carreras profesionales, en las que puedes encontrar un fabuloso medio de vida, haciendo algo que te gusta. Descúbrelo con esta guía:</span></p>\r\n<p class="p1"><span class="s1"><strong>1. Community manager</strong><br /> ¿Te pasas todo el día en Facebook y Twitter? ¿Te tienen que gritar para que te desconectes de la compu y te sientes a comer? Imagínate si, además de poder seguir conectado todo el santo día, te pagaran un sueldo por hacerlo… parece un sueño, pero es una de las profesiones del presente, y con mucho futuro. </span></p>\r\n<p class="p1"><span class="s1">La Licenciada <a href="http://www.consultoradecarrera.com.ar/mensaje_directora.php"><span class="s2"><strong>Melina Cataife</strong></span></a>, directora de la empresa <a href="http://www.consultoradecarrera.com.ar/"><span class="s2">Consultora de Carrera</span></a> y experta en temas de Recursos Humanos, explica que “el Community Manager es el representante de las empresas y las marcas en las redes sociales, y se encarga de garantizar la presencia de las mismas en la red”. Todos los conocimientos sobre las redes que ya tengas te ayudarán a desempeñarte mejor como profesional; aunque es bueno hacer un curso, por supuesto, para organizar y comprender mejor el perfil de tu tarea.</span></p>\r\n<p class="p1"><span class="s1"><strong>2. Artista multimedia</strong><br /> Esto es para ti si manejas como un dios las herramientas de audio y diseño digital, y eres un maestro para hacer blogs, páginas webs, insertar vídeos de Youtube, o retocar fotos del Face… Y es para ti si no sabes hacer nada de esto, ¡pero te encantaría! Cualquiera sea tu caso, esta profesión puede ser la tuya. El Artista Multimedia debe manejar herramientas de diseño, de animación, de sonido y de administración de contenidos. “Al igual que el Community Manager, son profesiones que nacen a partir de la web 2.0; e incluye tareas tales como el diseño y mantenimiento de páginas webs, newsletters, presentaciones multimedia, etc.” nos explica la Lic. Cataife.</span></p>\r\n<p class="p1"><span class="s1"><strong>3. Especialista en SEO</strong><br /> Otra carrera más ligada a la tecnología, especial para amantes de la vida on-line. Los expertos en SEO son los que se encargan de que el público que navega por Internet pueda encontrar los contenidos de una determinada web en los buscadores; su misión es posicionar la página de sus clientes, para que puedan competir con otras empresas; para ello, se especializan en identificar las palabras clave, analizar el marketing on line de sus competidores… ¡algo que puede ser muy divertido! Y que cada vez tiene más demanda.</span></p>\r\n<p class="p1"><span class="s1">Tanto para ejercer este nuevo oficio, como para los otros dos mencionados anteriormente, es una ventaja enorme ser bilingüe, condición que nos distingue a la mayoría de los Latinos. ¿Por qué? Porque muchas empresas ya comunican sus productos en inglés y español, y un profesional que pueda cubrir las dos demandas, resulta ideal ¡y puede ganar más!</span></p>\r\n<p class="p1"><span class="s1"><strong>4. Ingeniería medioambiental</strong><br /> Por la enorme contaminación del planeta, ésta es una de las profesiones con más futuro: la llamada ingeniería “verde”, o ingeniería medioambiental. Es especialmente interesante si te apasiona la ecología y te preocupa la preservación ambiental, ya que la misión que cumple este profesional, es proveer alternativas ecológicas y sustentables a las tecnologías tradicionales, así como el saneamiento y la limpieza de zonas con suelos y aguas contaminadas. Se calcula que en pocos años se duplicará la demanda laboral en este sector.</span></p>\r\n<p class="p1"><span class="s1"><strong>5. Nanomedicina</strong><br /> Si te interesa la medicina, pero no estás convencido del todo de seguir esta tradicional carrera profesional, tenemos buenas noticias: te puede interesar ser un nano-médico. Combinando la tecnología de punta con el noble oficio de curar, la Nanomedicina es la especialización en aparatos muy pequeños, especialmente diseñados para implantes y cirugías muy precisas y localizadas. Esta especialidad puede cambiar radicalmente la calidad de vida de la humanidad, y es un rubro en el cual lo mejor y lo más interesante, aún está por venir.</span></p>\r\n<p class="p2"><span class="s3"><br /> </span><span class="s1">Por: Elizabeth Levy Sad</span></p>\r\n<p class="p3"><span class="s1">Fuente: Revista Men’s Life Today</span></p>', '<p><span>En un mundo dominado por los cambios económicos y la revolución tecnológica, tu elección vocacional es algo clave para tu futuro bienestar. ¿Tienes una vocación ya definida? ¿O aún estás en la búsqueda de algo que te entusiasme, y a la vez, te deje dinero?</span></p>', '', '2013-02-18 17:37:10', 1, 'backend', '2013-03-07 15:55:20', 1, 'backend', '2013-03-07 15:55:41', 1, 1, 1, 0, 'a:3:{s:9:"metatitle";s:57:"5 profesiones con mucho futuro, que ni siquiera conocías";s:15:"metadescription";s:211:"                  En un mundo dominado por los cambios económicos y la revolución tecnológica, tu elección vocacional es algo clave para tu futuro bienestar. ¿Tienes una vocación ya definida? ¿O aú [...]";s:6:"header";s:0:"";}');

-- --------------------------------------------------------

--
-- Table structure for table `object_category`
--

DROP TABLE IF EXISTS `object_category`;
CREATE TABLE `object_category` (
  `object_id` int(11) NOT NULL default '0',
  `category_id` int(11) NOT NULL default '0',
  `category_parentid` int(11) NOT NULL default '0',
  `category_order` int(2) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `object_category`
--

INSERT INTO `object_category` VALUES(170, 103, 2, 0);
INSERT INTO `object_category` VALUES(171, 103, 2, 0);
INSERT INTO `object_category` VALUES(172, 106, 2, 0);
INSERT INTO `object_category` VALUES(173, 106, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `object_deleted`
--

DROP TABLE IF EXISTS `object_deleted`;
CREATE TABLE `object_deleted` (
  `object_id` int(11) NOT NULL auto_increment,
  `object_typeid` int(11) NOT NULL default '0',
  `object_parent` int(11) NOT NULL default '0',
  `object_title` varchar(500) default '',
  `object_shorttitle` varchar(255) default '',
  `object_content` text,
  `object_summary` text,
  `object_tags` varchar(255) default NULL,
  `creation_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `creation_userid` int(4) NOT NULL default '0',
  `creation_usertype` varchar(50) default '',
  `modification_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `modification_userid` int(4) NOT NULL default '0',
  `modification_usertype` varchar(50) default '',
  `publication_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `publication_userid` int(4) NOT NULL default '0',
  `object_state` int(1) NOT NULL default '0',
  `country_id` int(11) NOT NULL default '0',
  `location_id` int(11) NOT NULL default '0',
  `object_custom` text,
  PRIMARY KEY  (`object_id`),
  FULLTEXT KEY `busqueda` (`object_title`,`object_content`,`object_custom`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=180 ;

--
-- Dumping data for table `object_deleted`
--

INSERT INTO `object_deleted` VALUES(179, 1, 0, 'test', 'test', NULL, NULL, NULL, '2013-07-18 16:46:16', 1, 'backend', '0000-00-00 00:00:00', 0, '', '0000-00-00 00:00:00', 0, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `object_relation`
--

DROP TABLE IF EXISTS `object_relation`;
CREATE TABLE `object_relation` (
  `object_id` int(11) NOT NULL default '0',
  `object_typeid` int(11) NOT NULL default '0',
  `object_relationid` int(11) NOT NULL default '0',
  `object_relation_typeid` int(11) NOT NULL default '0',
  `object_relation_order1` int(11) NOT NULL default '0',
  `object_relation_order2` int(11) NOT NULL default '0',
  `object_relation_date` datetime NOT NULL default '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `object_relation`
--


-- --------------------------------------------------------

--
-- Table structure for table `object_type`
--

DROP TABLE IF EXISTS `object_type`;
CREATE TABLE `object_type` (
  `object_typeid` int(11) NOT NULL auto_increment,
  `object_typename` varchar(100) NOT NULL,
  PRIMARY KEY  (`object_typeid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `object_type`
--

INSERT INTO `object_type` VALUES(1, 'project');
INSERT INTO `object_type` VALUES(2, 'promo');
INSERT INTO `object_type` VALUES(3, 'page');
INSERT INTO `object_type` VALUES(4, 'country');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(100) NOT NULL,
  `shorttitle` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `creation_date` date NOT NULL,
  `modification_userid` int(11) NOT NULL default '0',
  `modification_usertype` int(11) NOT NULL,
  `state` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `project`
--

INSERT INTO `project` VALUES(1, 'Primer Proyecto', '', '', '2014-07-01', 0, 0, 0);
INSERT INTO `project` VALUES(2, '', '', '', '2014-07-01', 0, 0, 0);
INSERT INTO `project` VALUES(3, '', '', '', '2014-07-01', 0, 0, 0);
INSERT INTO `project` VALUES(4, 'teset', '', '', '2014-07-01', 0, 0, 0);
INSERT INTO `project` VALUES(5, 'Este proyecto bien creado', '', '', '2014-07-01', 0, 0, 0);
INSERT INTO `project` VALUES(6, 'Otro más', 'otro-mas', 'Este es la descripción del proyecto', '2014-07-01', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
CREATE TABLE `provider` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(100) NOT NULL,
  `shorttitle` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `cuit` varchar(100) default NULL,
  `phone` varchar(100) default NULL,
  `address` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `website` varchar(255) default NULL,
  `creation_date` datetime NOT NULL,
  `creation_userid` int(11) NOT NULL,
  `modification_date` datetime NOT NULL,
  `modification_userid` int(11) default NULL,
  `state` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `provider`
--

INSERT INTO `provider` VALUES(4, '', '', '', '', '', '', '', '', '2014-07-01 20:22:37', 0, '0000-00-00 00:00:00', NULL, 0);
INSERT INTO `provider` VALUES(5, 'Nuevo Proveedor', 'nuevo-proveedor', '', '', '', '', '', '', '2014-07-01 20:22:51', 0, '0000-00-00 00:00:00', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL auto_increment,
  `user_email` varchar(100) default '',
  `user_pass` varchar(200) NOT NULL default '0',
  `user_alias` varchar(30) default '',
  `user_name` varchar(100) default '',
  `user_lastname` varchar(100) default '',
  `user_dateborn` date NOT NULL default '0000-00-00',
  `user_documenttype` varchar(10) default '',
  `user_document` varchar(10) default '',
  `user_location` int(11) NOT NULL default '0',
  `user_active` int(1) NOT NULL default '0',
  `photo_id` int(1) NOT NULL default '0',
  `mail_suscription` int(1) NOT NULL default '1',
  `mail_response` int(1) NOT NULL default '1',
  `mail_listas` int(1) NOT NULL default '1',
  `user_migrado` int(1) NOT NULL default '1',
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `user`
--


-- --------------------------------------------------------

--
-- Table structure for table `user_admin`
--

DROP TABLE IF EXISTS `user_admin`;
CREATE TABLE `user_admin` (
  `user_id` int(11) NOT NULL auto_increment,
  `user_email` varchar(100) default '',
  `user_password` varchar(200) NOT NULL default '0',
  `username` varchar(30) default NULL,
  `user_name` varchar(100) default '',
  `user_lastname` varchar(100) default '',
  `user_active` int(1) NOT NULL default '0',
  `photo_id` int(1) NOT NULL default '0',
  `access_level` int(1) NOT NULL default '0',
  `site_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `alias` (`username`),
  UNIQUE KEY `email` (`user_email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `user_admin`
--

INSERT INTO `user_admin` VALUES(1, 'ariel@frooit.com', '6c7f6e6d6c797e736e7328', 'admin', 'Ariel', 'Velaz', 0, 0, 1, 1);
INSERT INTO `user_admin` VALUES(11, 'dario@godaro.com', '666c686964787865797f', 'godaro', 'Dario', 'Aguilar', 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_level`
--

DROP TABLE IF EXISTS `user_level`;
CREATE TABLE `user_level` (
  `user_level_id` int(11) NOT NULL auto_increment,
  `user_level_name` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`user_level_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user_level`
--

INSERT INTO `user_level` VALUES(1, 'administrator');
INSERT INTO `user_level` VALUES(2, 'editor');
INSERT INTO `user_level` VALUES(3, 'subeditor');
INSERT INTO `user_level` VALUES(4, 'colaborator');
