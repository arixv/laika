-- phpMyAdmin SQL Dump
-- version 3.3.10.4
-- http://www.phpmyadmin.net
--
-- Host: mysql.urltester.com.ar
-- Generation Time: Aug 28, 2014 at 05:01 AM
-- Server version: 5.1.56
-- PHP Version: 5.3.27

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `laika_urltester`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL DEFAULT '',
  `category_parent` int(11) NOT NULL DEFAULT '0',
  `category_order` int(3) DEFAULT '0',
  `category_url` varchar(255) DEFAULT '',
  `category_highlight` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

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
CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `title`, `shorttitle`, `description`, `cuit`, `phone`, `address`, `email`, `website`, `creation_date`, `creation_userid`, `modification_date`, `modification_userid`, `state`) VALUES
(11, 'MTV ', 'mtv-', '', '', '', '', '', '', '2014-08-10 10:55:00', 0, '0000-00-00 00:00:00', 17, 0),
(10, 'Autopistas del Sol S.A.       ', 'autopistas-del-sol-sa--', '', '30-67723711-9', '5789.8757', 'PANAMERICANA 2451 - BOULOGNE (B1609JVF)', 'helorriaga@ausol.com.ar', 'https://www.ausol.com.ar/ ', '2014-08-08 11:54:33', 0, '0000-00-00 00:00:00', 16, 0),
(4, 'Paka Paka', 'paka-paka', '', '30-32424234-0', 'xxx', 'xx', '', '', '2014-07-03 17:33:34', 0, '0000-00-00 00:00:00', NULL, 0),
(9, 'Ministerio de Cultura de la Nación', 'ministerio-de-cultura-de-la-nacion', '', '', '', 'Alvear 1690', '', '', '2014-08-07 20:18:20', 0, '0000-00-00 00:00:00', 16, 0),
(8, 'Educ.ar', 'educar', '', '', '47044000', 'Comodoro Rivadavia 1151', '', '', '2014-07-30 18:31:43', 0, '0000-00-00 00:00:00', 17, 0),
(12, 'AD ONE', 'ad-one', '', '', '', '', '', '', '2014-08-10 10:55:20', 0, '0000-00-00 00:00:00', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `objecttype_id` int(11) NOT NULL DEFAULT '1',
  `object_id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `comment_content` text,
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `state_id` int(1) NOT NULL DEFAULT '1',
  `user_report` int(11) NOT NULL DEFAULT '0',
  `motive_report` varchar(255) DEFAULT '',
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `comment`
--


-- --------------------------------------------------------

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
CREATE TABLE IF NOT EXISTS `factura` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `partida_id` int(11) NOT NULL,
  `resource_id` int(11) DEFAULT '0',
  `subrubro_id` int(11) NOT NULL DEFAULT '0',
  `number` varchar(100) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `description` text,
  `amount` varchar(100) DEFAULT NULL,
  `date` date NOT NULL,
  `state` int(1) NOT NULL DEFAULT '0',
  `creation_userid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `factura`
--

INSERT INTO `factura` (`id`, `project_id`, `provider_id`, `partida_id`, `resource_id`, `subrubro_id`, `number`, `type`, `description`, `amount`, `date`, `state`, `creation_userid`) VALUES
(8, 10, 0, 0, 0, 28, '4', 'C', 'Honorarios del Director del Proyecto', '6000', '2014-07-10', 1, 1),
(6, 10, 11, 0, 0, 8, '2', 'A', 'Pago de Luces', '1000', '2014-07-10', 1, 1),
(7, 10, 11, 0, 0, 8, '3', 'A', 'Otra Factura de Luces', '1000', '2014-07-10', 1, 1),
(9, 10, 0, 0, 0, 14, '5', 'A', 'Pago de Flat Car', '1000', '2014-07-11', 1, 1),
(10, 10, 0, 0, 0, 5, '5', 'A', 'Pago Alquiler de Cámaras', '500', '2014-07-11', 1, 1),
(11, 10, 0, 17, 0, 0, '12', 'A', '', '1200', '2014-07-12', 1, 1),
(14, 12, 0, 0, 0, 5, '1', 'A', '', '2000', '2014-07-11', 1, 1),
(12, 10, 11, 11, 0, 0, '6', 'A', 'desc', '15000', '2014-07-11', 0, 1),
(13, 10, 0, 10, 0, 0, '9', 'A', 'desc', '1000', '2014-07-18', 0, 1),
(16, 29, 11, 20, 0, 5, '1', 'A', '', '40000', '2014-07-22', 1, 1),
(17, 29, 0, 20, 0, 5, '5', 'A', '', '30000', '2014-07-23', 1, 1),
(18, 29, 0, 0, 0, 44, '3', 'A', '', '800', '2014-07-23', 1, 1),
(19, 29, 0, 0, 0, 11, '4', 'A', '', '1200', '2014-07-22', 1, 1),
(20, 29, 0, 0, 0, 8, '2', 'A', '', '1000', '2014-07-22', 1, 1),
(21, 34, 0, 0, 0, 43, '121', 'A', '', '2500', '2014-07-31', 1, 1),
(22, 34, 35, 0, 0, 43, '', 'A', '', '1000', '0000-00-00', 0, 1),
(23, 34, 0, 24, 0, 0, '', 'B', '', '15', '0000-00-00', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(255) DEFAULT '',
  `menu_parent` int(11) NOT NULL DEFAULT '0',
  `menu_url` varchar(255) DEFAULT '',
  `menu_order` int(5) NOT NULL DEFAULT '0',
  `menu_state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`menu_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

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
CREATE TABLE IF NOT EXISTS `multimedia` (
  `multimedia_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `object_custom` text,
  PRIMARY KEY (`multimedia_id`),
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
CREATE TABLE IF NOT EXISTS `multimedia_category` (
  `multimedia_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `category_parentid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `multimedia_category`
--


-- --------------------------------------------------------

--
-- Table structure for table `multimedia_deleted`
--

DROP TABLE IF EXISTS `multimedia_deleted`;
CREATE TABLE IF NOT EXISTS `multimedia_deleted` (
  `multimedia_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `object_custom` text,
  PRIMARY KEY (`multimedia_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

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
CREATE TABLE IF NOT EXISTS `multimedia_object` (
  `object_id` int(11) NOT NULL DEFAULT '0',
  `multimedia_id` int(11) NOT NULL DEFAULT '0',
  `relation_order` int(3) NOT NULL DEFAULT '0',
  `object_typeid` int(11) NOT NULL DEFAULT '0',
  `multimedia_typeid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `multimedia_object`
--


-- --------------------------------------------------------

--
-- Table structure for table `object`
--

DROP TABLE IF EXISTS `object`;
CREATE TABLE IF NOT EXISTS `object` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `object_custom` text,
  PRIMARY KEY (`object_id`),
  FULLTEXT KEY `busqueda` (`object_title`,`object_content`,`object_custom`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=180 ;

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
CREATE TABLE IF NOT EXISTS `object_category` (
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
CREATE TABLE IF NOT EXISTS `object_deleted` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `object_custom` text,
  PRIMARY KEY (`object_id`),
  FULLTEXT KEY `busqueda` (`object_title`,`object_content`,`object_custom`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=180 ;

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
CREATE TABLE IF NOT EXISTS `object_relation` (
  `object_id` int(11) NOT NULL DEFAULT '0',
  `object_typeid` int(11) NOT NULL DEFAULT '0',
  `object_relationid` int(11) NOT NULL DEFAULT '0',
  `object_relation_typeid` int(11) NOT NULL DEFAULT '0',
  `object_relation_order1` int(11) NOT NULL DEFAULT '0',
  `object_relation_order2` int(11) NOT NULL DEFAULT '0',
  `object_relation_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `object_relation`
--


-- --------------------------------------------------------

--
-- Table structure for table `object_type`
--

DROP TABLE IF EXISTS `object_type`;
CREATE TABLE IF NOT EXISTS `object_type` (
  `object_typeid` int(11) NOT NULL AUTO_INCREMENT,
  `object_typename` varchar(100) NOT NULL,
  PRIMARY KEY (`object_typeid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

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
CREATE TABLE IF NOT EXISTS `partida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `responsable` varchar(100) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `amount` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  `creation_userid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `partida`
--

INSERT INTO `partida` (`id`, `description`, `responsable`, `project_id`, `amount`, `date`, `creation_userid`) VALUES
(1, 'Descripción de la partida', 'Ariel Velaz', 6, '40000', '0000-00-00 00:00:00', 1),
(2, 'Otra Partida', 'Adrian', 6, '12012', '2014-07-02 00:00:00', 1),
(3, 'Otra Partida 222', 'Adrian', 6, '12012', '2014-07-02 00:00:00', 1),
(4, 'Otra Partida 333', 'Dario', 6, '25000', '2014-07-02 00:00:00', 1),
(5, 'Partida #1', 'Matias', 8, '1200', '2011-11-11 00:00:00', 1),
(6, 'Partida #2', 'Jorge', 8, '1200', '2014-07-02 00:00:00', 1),
(10, 'Lorem ipsum', 'Matias', 10, '1200', '2014-07-11 00:00:00', 1),
(8, 'Partida #3', 'Guillermo', 8, '5000', '2014-07-02 00:00:00', 1),
(9, 'Lorem ipsum', 'Adrian', 8, '1200', '2014-07-02 00:00:00', 1),
(11, 'Otra Partida', 'Matias', 10, '1000', '2014-07-02 00:00:00', 1),
(12, 'Danger Partida', 'Matias', 10, '1200', '2014-07-02 00:00:00', 1),
(15, 'Lorem ipsum', 'Matias2', 10, '5', '2014-07-02 00:00:00', 1),
(17, 'PArtida Solicitada por matias', 'Matias', 10, '25000', '2014-07-09 00:00:00', 1),
(18, 'desc', 'Matias', 14, '15000', '2014-07-16 00:00:00', 1),
(19, 'desc2', 'Matias', 14, '1200', '2014-07-16 00:00:00', 1),
(20, 'Partida de Producción', 'Adrian', 29, '1000', '2014-07-22 00:00:00', 1),
(21, 'Partida de Sonido', 'Matias', 29, '30000', '2014-07-22 00:00:00', 1),
(22, '', 'Adrian', 30, '1000', '2014-07-29 00:00:00', 1),
(23, '', '', 34, '1000', '2014-08-15 00:00:00', 1),
(24, 'movilidad 1', 'camila', 34, '1000', '2014-08-03 00:00:00', 1),
(25, 'Partida #7', '', 38, '4000', '2014-08-04 00:00:00', 18),
(26, 'Partida de producción para catering y transporte.\r\nEntregada por Sebastián Mignogna', 'Producción', 36, '450', '2014-08-08 00:00:00', 17),
(27, '', '', 33, '5000', '0000-00-00 00:00:00', 17),
(28, '', '', 33, '700', '0000-00-00 00:00:00', 17);

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `title`, `shorttitle`, `description`, `type_option_programas`, `type_option_segundaje`, `type_option_producto`, `type_option_duracion`, `type_option_medio`, `type_option_tipo_servicio`, `budget`, `imprevistos`, `ganancia`, `impuestos`, `iva`, `impuesto_cheque`, `otros_impuestos`, `creation_date`, `start_date`, `end_date`, `client_id`, `type`, `creation_userid`, `modification_userid`, `modification_usertype`, `state`) VALUES
(38, 'AUSOL Fee mensual - Agosto', 'ausol-fee-mensual-agosto', 'Mantenimiento mensual, time lapse, edición y salidas de rodaje', '', '', '', '', '', 'material de TV', '0', 2.00, 24.62, 1.20, 21.00, 1.00, 0.00, '2014-08-08', '2014-08-01', '2014-08-31', 10, 'Servicio', 18, 18, 0, 1),
(30, 'PROYECTO DE TV', 'proyecto-de-tv', 'descripción del proyecto', '10', '10 días', '', '', '', '', '0', 3.00, 25.00, 1.20, 0.00, 0.00, 0.00, '2014-07-28', '2014-07-01', '2014-07-10', 4, 'TV', 1, 12, 0, 0),
(31, 'PROYECTO DE PUBLICIDAD', 'proyecto-de-publicidad', '                        \r\n                      ', '', '', 'DISNEY PRINCESAS', '10 HORAS', 'WEB', '', '0', 3.00, 20.00, 1.20, 0.00, 0.00, 0.00, '2014-07-28', '2014-08-05', '2014-08-27', 8, 'Publicidad', 1, 12, 0, 0),
(36, 'Cultura - Invasiones Inglesas', 'cultura-invasiones-inglesas', 'Micro de  3/4 minutos para el Ministerio de Cultura.\r\nRecrea la reconquista de Buenos Aires en 1806 a partir de una historieta.', '1', '4 minutos', '', '', '', '', '0', 0.00, 20.00, 21.00, 0.00, 0.00, 0.00, '2014-08-07', '2014-08-07', '2014-08-11', 9, 'TV', 17, 16, 0, 1),
(33, 'Spot Defensa del Consumidor', 'spot-defensa-del-consumidor', '                        \r\n                      ', '1', '3 min 30 seg', '', '', '', '', '0', 0.00, 10.00, 21.00, 0.00, 0.00, 0.00, '2014-07-30', '2014-07-23', '2014-07-31', 8, 'TV', 12, 18, 0, 0),
(39, 'Proyecto de Prueba', 'proyecto-de-prueba', 'Descripción', '2', '10 días', '', '', '', '', '0', 3.00, 20.00, 1.20, 21.00, 0.00, 0.00, '2014-08-22', '2014-08-01', '2014-08-31', 11, 'TV', 12, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `project_resource`
--

DROP TABLE IF EXISTS `project_resource`;
CREATE TABLE IF NOT EXISTS `project_resource` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `rubro_id` int(11) NOT NULL,
  `subrubro_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL DEFAULT '0',
  `estimate_units` int(11) NOT NULL DEFAULT '0',
  `estimate_quantity` int(11) NOT NULL DEFAULT '0',
  `estimate_cost` decimal(15,2) NOT NULL,
  `units` int(11) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `concept` varchar(100) NOT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  `state` int(1) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `payments` int(11) NOT NULL,
  `payment_type` varchar(100) NOT NULL,
  `creation_userid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=195 ;

--
-- Dumping data for table `project_resource`
--

INSERT INTO `project_resource` (`resource_id`, `project_id`, `rubro_id`, `subrubro_id`, `provider_id`, `estimate_units`, `estimate_quantity`, `estimate_cost`, `units`, `quantity`, `description`, `concept`, `cost`, `state`, `start_date`, `end_date`, `payments`, `payment_type`, `creation_userid`) VALUES
(6, 10, 4, 8, 0, 0, 0, 0.00, 0, 10, 'Descripción de la factura', 'Mensual', 200.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(7, 10, 4, 5, 0, 0, 0, 0.00, 0, 10, 'test222\r\n', 'Unidad', 200.00, 0, '0000-00-00', '0000-00-00', 3, 'Iguales', 1),
(12, 10, 17, 28, 0, 0, 0, 0.00, 0, 60, 'Pago al Director', 'Diario', 25000.00, 0, '2014-07-10', '2014-07-31', 60, 'Iguales', 1),
(13, 10, 4, 14, 0, 0, 0, 0.00, 0, 10, '', 'Programas', 200.00, 0, '2014-07-11', '2014-07-12', 2, 'Iguales', 1),
(14, 9, 4, 5, 0, 0, 0, 0.00, 0, 10, 'test', 'Unidad', 1000.00, 0, '2014-07-11', '2014-07-11', 3, 'Diferentes', 1),
(15, 12, 4, 5, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(21, 14, 4, 8, 0, 0, 0, 0.00, 0, 5, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(23, 14, 4, 11, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 15500.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(22, 14, 4, 8, 0, 0, 0, 0.00, 0, 5, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(20, 14, 4, 5, 0, 0, 0, 0.00, 0, 2, 'Alquiler de Cámaras', 'Unidad', 5000.00, 0, '2014-07-16', '2014-07-31', 10, 'Iguales', 1),
(24, 14, 4, 9, 0, 0, 0, 0.00, 0, 2, '', 'Unidad', 25000.00, 0, '1901-01-01', '1901-01-31', 1, 'Iguales', 1),
(25, 14, 32, 36, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 50000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(26, 14, 32, 37, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 30000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(27, 14, 32, 33, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 50000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(28, 17, 4, 5, 0, 0, 0, 0.00, 0, 12, 'desc', 'Mensual', 100.00, 0, '2014-07-16', '2014-07-31', 1, 'Iguales', 1),
(29, 22, 4, 5, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 1500.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(30, 22, 4, 8, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 2000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(31, 22, 4, 11, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 3000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(32, 25, 4, 5, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 1500.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(33, 25, 4, 8, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 2000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(34, 25, 4, 11, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 3000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(35, 13, 4, 5, 0, 0, 0, 0.00, 0, 10, '', 'Mensual', 25000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(36, 13, 4, 8, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 100.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(37, 13, 4, 13, 0, 0, 0, 0.00, 0, 2, '', 'Unidad', 100.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(41, 27, 4, 8, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 100.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(39, 26, 4, 8, 0, 0, 1, 1000.00, 0, 0, '', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(40, 26, 4, 13, 0, 0, 2, 500.00, 0, 0, '', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(42, 27, 4, 13, 0, 0, 0, 0.00, 0, 2, '', 'Unidad', 100.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(47, 28, 4, 5, 0, 0, 1, 1000.00, 0, 2, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(48, 28, 4, 8, 0, 0, 1, 1000.00, 0, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(49, 28, 42, 44, 0, 0, 1, 222.00, 0, 1, '', 'Unidad', 222.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(50, 28, 42, 43, 0, 0, 2, 1000.00, 0, 2, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(51, 29, 4, 5, 10, 0, 1, 1500.00, 0, 2, '', 'Unidad', 1300.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(52, 29, 42, 44, 0, 0, 1, 1000.00, 0, 1, '', 'Unidad', 800.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(53, 29, 4, 8, 11, 0, 10, 1000.00, 0, 9, 'Luces Ambientales', 'Unidad', 1000.00, 0, '2014-07-01', '2014-07-10', 1, 'Iguales', 1),
(54, 29, 4, 11, 7, 0, 1, 1000.00, 0, 2, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(55, 29, 4, 14, 7, 0, 2, 13.00, 0, 3, 'test', 'Unidad', 13.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(56, 31, 4, 8, 9, 0, 0, 0.00, 0, 0, '', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(57, 32, 4, 8, 11, 0, 0, 0.00, 0, 0, '', 'Mensual', 0.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(58, 28, 4, 13, 8, 0, 1, 1500.00, 0, 1, '', 'Unidad', 1500.00, 0, '2014-07-02', '2014-07-09', 2, 'Iguales', 1),
(59, 30, 4, 5, 11, 0, 1, 1000.00, 0, 1, 'test', 'Unidad', 1000.00, 0, '2014-07-29', '2014-07-31', 2, 'Iguales', 1),
(143, 33, 6, 82, 0, 1, 1, 2000.00, 1, 1, '', 'Global', 2000.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(144, 38, 32, 17, 0, 1, 1, 19000.00, 1, 1, '', 'Unidad', 19000.00, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(138, 33, 38, 40, 0, 1, 1, 7500.00, 1, 1, '', 'Global', 7500.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(107, 35, 4, 5, 36, 0, 1, 1000.00, 0, 1, '', 'Unidad', 1000.00, 0, '2014-08-01', '2014-08-21', 0, '', 1),
(69, 34, 42, 43, 36, 0, 1, 4200.00, 0, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(106, 34, 42, 43, 36, 0, 0, 0.00, 0, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(105, 34, 42, 43, 36, 0, 0, 0.00, 0, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(103, 34, 50, 56, 36, 0, 0, 0.00, 0, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(78, 34, 18, 57, 0, 0, 1, 1800.00, 0, 1, '', 'Global', 1800.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(79, 34, 18, 58, 0, 0, 1, 7500.00, 0, 1, '', 'Global', 7500.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(80, 34, 18, 73, 0, 0, 1, 558.00, 0, 1, '', 'Global', 558.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(104, 34, 42, 43, 36, 0, 0, 0.00, 0, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 1, 'Iguales', 1),
(83, 34, 60, 63, 0, 0, 1, 3500.00, 0, 1, '', 'Global', 3500.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(95, 34, 66, 67, 0, 0, 1, 90.00, 0, 1, '', 'Global', 90.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(94, 34, 60, 64, 0, 0, 1, 1200.00, 0, 1, '', 'Global', 1200.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(86, 34, 66, 68, 0, 0, 1, 16.00, 0, 1, '', 'Global', 16.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(93, 34, 60, 65, 0, 0, 1, 10000.00, 0, 1, '', 'Global', 10000.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(92, 34, 17, 28, 0, 0, 1, 7500.00, 0, 1, '', 'Global', 7500.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(89, 34, 75, 76, 0, 0, 1, 350.00, 0, 1, '', 'Global', 350.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(90, 34, 75, 77, 0, 0, 1, 400.00, 0, 1, '', 'Global', 400.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(91, 34, 75, 78, 0, 0, 1, 300.00, 0, 1, '', 'Global', 300.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(108, 35, 4, 14, 0, 0, 0, 0.00, 0, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(110, 31, 4, 5, 34, 0, 0, 0.00, 0, 5, '', 'Diario', 10000.00, 0, '0000-00-00', '0000-00-00', 0, '', 1),
(145, 38, 38, 40, 40, 1, 1, 16520.00, 1, 1, '', 'Unidad', 16520.00, 0, '2014-08-01', '2014-08-31', 0, '', 18),
(139, 33, 38, 41, 0, 1, 1, 4000.00, 1, 1, '', 'Global', 4000.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(137, 33, 42, 43, 0, 1, 1, 4000.00, 1, 1, '', 'Global', 4000.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(140, 33, 50, 56, 0, 1, 1, 6500.00, 1, 1, '', 'Global', 6500.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(136, 33, 17, 28, 27, 1, 1, 12000.00, 1, 1, '', 'Unidad', 12000.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(111, 36, 32, 34, 40, 0, 1, 9000.00, 0, 1, 'Dirección', 'Unidad', 6000.00, 0, '2014-08-08', '2014-08-11', 2, 'Iguales', 17),
(112, 36, 38, 40, 0, 0, 1, 5500.00, 0, 1, '', 'Unidad', 2800.00, 0, '0000-00-00', '0000-00-00', 2, 'Iguales', 17),
(113, 36, 50, 53, 0, 0, 1, 6000.00, 0, 1, 'Leandro Piccarreta', 'Unidad', 3000.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(114, 36, 50, 56, 0, 0, 1, 2000.00, 0, 1, 'Posibles horas extras de editor fin de semana', 'Unidad', 1500.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(115, 36, 60, 64, 0, 0, 3, 350.00, 0, 0, '', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(116, 36, 42, 43, 30, 0, 1, 1500.00, 0, 0, 'Martín o Rai?', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(117, 36, 66, 69, 0, 0, 2, 1500.00, 0, 1, 'Estación Animación + Estación edición', 'Unidad', 1500.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(118, 36, 66, 68, 0, 0, 10, 15.00, 0, 0, 'Material Virgen para entrega', 'Global', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(119, 36, 18, 58, 0, 0, 1, 2500.00, 0, 1, 'Locutor', 'Unidad', 4000.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(121, 36, 75, 76, 0, 0, 1, 500.00, 0, 0, 'Seguros varios', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(122, 36, 60, 63, 0, 0, 1, 3000.00, 0, 1, 'Sono, mezcla y musicalización', 'Unidad', 2500.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(123, 36, 16, 29, 0, 0, 1, 2500.00, 0, 1, 'Comidas', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 17),
(124, 37, 32, 34, 0, 0, 1, 9000.00, 0, 1, 'Dirección', 'Unidad', 9000.00, 0, '2014-08-08', '2014-08-11', 0, '', 17),
(125, 37, 38, 40, 0, 0, 1, 5500.00, 0, 1, 'Productor', 'Unidad', 5500.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(126, 37, 50, 53, 0, 0, 1, 6000.00, 0, 1, 'Leandro Piccarreta', 'Unidad', 6000.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(127, 37, 50, 56, 0, 0, 1, 2000.00, 0, 1, 'Posibles horas extras de editor fin de semana', 'Unidad', 2000.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(128, 37, 60, 64, 25, 0, 3, 350.00, 0, 3, '', 'Unidad', 350.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(129, 37, 42, 43, 31, 0, 1, 1500.00, 0, 1, 'Martín o Rai?', 'Unidad', 1500.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(130, 37, 66, 69, 0, 0, 2, 1500.00, 0, 2, 'Estación Animación + Estación edición', 'Unidad', 1500.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(131, 37, 66, 68, 0, 0, 10, 15.00, 0, 0, 'Material Virgen para entrega', 'Global', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(132, 37, 18, 58, 0, 0, 1, 2500.00, 0, 1, 'Locutor', 'Unidad', 2500.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(133, 37, 75, 76, 0, 0, 1, 500.00, 0, 0, 'Seguros varios', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(134, 37, 60, 63, 24, 0, 1, 3000.00, 0, 1, 'Sono, mezcla y musicalización', 'Unidad', 3000.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(135, 37, 16, 29, 0, 0, 1, 2500.00, 0, 1, 'Comidas', 'Unidad', 2500.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(146, 38, 6, 82, 40, 1, 1, 8400.00, 1, 1, '', 'Unidad', 14000.00, 0, '2014-08-08', '0000-00-00', 0, 'Iguales', 18),
(147, 38, 6, 84, 0, 1, 1, 1680.00, 1, 1, '', 'Global', 0.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 18),
(148, 38, 6, 7, 0, 1, 1, 2100.00, 1, 1, '', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 18),
(149, 38, 6, 85, 40, 1, 1, 20000.00, 1, 1, '', 'Unidad', 10500.00, 0, '0000-00-00', '0000-00-00', 0, 'Iguales', 18),
(150, 38, 50, 56, 40, 1, 1, 9100.00, 1, 1, '', 'Unidad', 9100.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(151, 38, 60, 63, 0, 1, 1, 3000.00, 1, 1, '', 'Global', 3000.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(152, 38, 60, 83, 0, 1, 1, 6000.00, 1, 1, '', 'Unidad', 6000.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(153, 38, 60, 86, 0, 1, 1, 1600.00, 1, 1, '', 'Unidad', 1600.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(178, 38, 60, 102, 0, 1, 1, 6000.00, 1, 1, '', 'Unidad', 6000.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(155, 38, 50, 87, 0, 1, 1, 4500.00, 1, 1, '', 'Unidad', 4500.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(156, 38, 4, 5, 40, 1, 6, 500.00, 1, 6, '', 'Unidad', 500.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(157, 38, 4, 88, 0, 1, 3, 250.00, 1, 3, '', 'Unidad', 250.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(158, 38, 4, 11, 40, 1, 1, 600.00, 1, 1, '', 'Unidad', 600.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(159, 38, 89, 90, 40, 1, 1, 1200.00, 1, 1, '', 'Unidad', 1200.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(160, 38, 91, 92, 0, 1, 1, 10000.00, 1, 1, '', 'Unidad', 10000.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(161, 38, 91, 95, 40, 1, 1, 3500.00, 1, 1, '', 'Unidad', 3500.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(162, 38, 16, 97, 40, 1, 1, 2500.00, 1, 1, '', 'Unidad', 2500.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(163, 38, 16, 99, 40, 1, 1, 1200.00, 1, 1, '', 'Unidad', 1200.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(164, 38, 16, 100, 40, 1, 1, 2000.00, 1, 1, '', 'Unidad', 2000.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(179, 33, 66, 101, 0, 1, 1, 800.00, 1, 1, '', 'Unidad', 800.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(166, 38, 75, 76, 0, 1, 1, 1200.00, 1, 1, '', 'Unidad', 1200.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(167, 38, 75, 77, 0, 1, 1, 900.00, 1, 1, '', 'Unidad', 900.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(168, 38, 16, 31, 40, 1, 1, 1295.00, 1, 1, '', 'Unidad', 1295.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(169, 38, 91, 96, 40, 1, 1, 3000.00, 1, 1, '', 'Unidad', 3000.00, 0, '0000-00-00', '0000-00-00', 0, '', 18),
(170, 33, 89, 90, 40, 1, 1, 2000.00, 1, 1, '', 'Unidad', 2000.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(171, 33, 60, 63, 0, 1, 1, 6000.00, 1, 1, '', 'Global', 6000.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(173, 33, 16, 99, 0, 1, 1, 500.00, 1, 1, '', 'Unidad', 500.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(174, 33, 75, 77, 0, 1, 1, 350.00, 1, 1, '', 'Unidad', 350.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(175, 33, 75, 78, 0, 1, 1, 250.00, 1, 1, '', 'Unidad', 250.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(176, 38, 38, 41, 40, 1, 0, 0.00, 1, 0, '', 'Unidad', 0.00, 0, '2014-08-01', '2014-08-31', 0, 'Iguales', 18),
(177, 38, 6, 85, 0, 1, 0, 0.00, 1, 1, '', 'Unidad', 1844.00, 0, '2014-08-01', '2014-08-31', 1, 'Iguales', 18),
(180, 33, 91, 96, 0, 1, 1, 1500.00, 1, 1, '', 'Unidad', 1500.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(181, 33, 91, 107, 0, 1, 1, 2000.00, 1, 1, '', 'Unidad', 2000.00, 0, '0000-00-00', '0000-00-00', 0, '', 14),
(182, 33, 75, 76, 40, 1, 1, 300.00, 1, 1, '', 'Unidad', 300.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(183, 33, 16, 29, 0, 1, 1, 1000.00, 1, 1, '', 'Global', 1000.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(184, 33, 18, 58, 0, 1, 1, 8000.00, 1, 1, '', 'Global', 8000.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(185, 33, 4, 5, 34, 1, 1, 2500.00, 1, 1, '', 'Unidad', 2500.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(186, 33, 50, 87, 0, 1, 1, 8000.00, 1, 1, '', 'Global', 8000.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(187, 33, 91, 107, 0, 1, 1, 1500.00, 1, 1, '', 'Global', 1500.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(188, 33, 4, 8, 29, 1, 0, 0.00, 1, 0, '', 'Global', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(189, 33, 60, 65, 0, 1, 0, 0.00, 1, 0, '', 'Global', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(190, 33, 18, 73, 0, 1, 0, 0.00, 1, 0, '', 'Programas', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(191, 33, 18, 74, 0, 1, 0, 0.00, 1, 0, '', 'Unidad', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(192, 33, 91, 106, 0, 1, 0, 0.00, 1, 0, '', 'Global', 0.00, 0, '0000-00-00', '0000-00-00', 0, '', 17),
(194, 39, 16, 97, 29, 2, 1, 1000.00, 2, 1, '', 'Unidad', 1000.00, 0, '0000-00-00', '0000-00-00', 0, '', 12);

-- --------------------------------------------------------

--
-- Table structure for table `project_resource_payments`
--

DROP TABLE IF EXISTS `project_resource_payments`;
CREATE TABLE IF NOT EXISTS `project_resource_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `value` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `project_resource_payments`
--

INSERT INTO `project_resource_payments` (`id`, `project_id`, `resource_id`, `date`, `value`) VALUES
(1, 14, 8, '2014-07-16', 5000.00),
(2, 14, 8, '2014-07-17', 5000.00),
(3, 14, 8, '2014-07-18', 5000.00),
(4, 14, 8, '2014-07-19', 5000.00),
(5, 14, 8, '2014-07-20', 5000.00),
(6, 14, 5, '2014-07-16', 2000.00),
(7, 14, 5, '2014-07-17', 2000.00),
(8, 14, 5, '2014-07-18', 2000.00),
(9, 14, 5, '2014-07-19', 2000.00),
(10, 14, 5, '2014-07-20', 2000.00),
(11, 17, 5, '2014-07-16', 1200.00),
(12, 34, 52, '2014-08-01', 2500.00),
(19, 36, 112, '2014-08-19', 1400.00),
(18, 36, 111, '2014-08-12', 3000.00),
(17, 36, 111, '2014-08-11', 3000.00),
(20, 36, 112, '2014-08-27', 1400.00);

-- --------------------------------------------------------

--
-- Table structure for table `project_rubro`
--

DROP TABLE IF EXISTS `project_rubro`;
CREATE TABLE IF NOT EXISTS `project_rubro` (
  `project_id` int(11) NOT NULL,
  `rubro_id` int(11) NOT NULL,
  `state` int(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_rubro`
--

INSERT INTO `project_rubro` (`project_id`, `rubro_id`, `state`) VALUES
(10, 17, 0),
(10, 4, 0),
(9, 4, 0),
(12, 4, 0),
(14, 4, 0),
(14, 32, 0),
(17, 4, 0),
(22, 4, 0),
(13, 4, 0),
(26, 4, 0),
(27, 4, 0),
(28, 4, 0),
(28, 42, 0),
(29, 4, 0),
(29, 42, 0),
(31, 4, 0),
(32, 4, 0),
(30, 4, 0),
(33, 4, 0),
(33, 17, 0),
(33, 38, 0),
(33, 42, 0),
(34, 50, 0),
(34, 42, 0),
(35, 4, 0),
(34, 18, 0),
(34, 60, 0),
(34, 66, 0),
(34, 75, 0),
(34, 17, 0),
(33, 50, 0),
(36, 32, 0),
(36, 38, 0),
(36, 50, 0),
(36, 60, 0),
(36, 42, 0),
(36, 66, 0),
(36, 18, 0),
(36, 75, 0),
(36, 16, 0),
(37, 32, 0),
(37, 38, 0),
(37, 50, 0),
(37, 60, 0),
(37, 42, 0),
(37, 66, 0),
(37, 18, 0),
(37, 75, 0),
(37, 16, 0),
(39, 16, 0),
(38, 32, 0),
(33, 6, 0),
(38, 38, 0),
(38, 6, 0),
(38, 50, 0),
(38, 60, 0),
(38, 4, 0),
(38, 89, 0),
(38, 91, 0),
(38, 16, 0),
(38, 75, 0),
(33, 89, 0),
(33, 60, 0),
(33, 16, 0),
(33, 75, 0),
(33, 66, 0),
(33, 91, 0),
(33, 18, 0);

-- --------------------------------------------------------

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
CREATE TABLE IF NOT EXISTS `provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `shorttitle` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `cuit` varchar(100) DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `creation_userid` int(11) NOT NULL,
  `modification_date` datetime NOT NULL,
  `modification_userid` int(11) DEFAULT NULL,
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=47 ;

--
-- Dumping data for table `provider`
--

INSERT INTO `provider` (`id`, `title`, `shorttitle`, `description`, `cuit`, `category`, `phone`, `address`, `email`, `website`, `creation_date`, `creation_userid`, `modification_date`, `modification_userid`, `state`) VALUES
(19, 'Joaquin Mustafa Torres ', 'joaquin-mustafa-torres-', '', '', '', '', '', '', '', '2014-07-31 16:05:57', 0, '0000-00-00 00:00:00', NULL, 0),
(20, 'Facundo Reyes ', 'facundo-reyes-', '', '', '', '', '', '', '', '2014-07-31 16:06:16', 0, '0000-00-00 00:00:00', NULL, 1),
(16, 'Telma Martin', 'telma-martin', '', '', '', '1135815657', '', 'telmamartin@gmail.com', '', '2014-07-31 15:49:03', 0, '0000-00-00 00:00:00', NULL, 1),
(18, 'Adrian Nallim', 'adrian-nallim', '', '', 'Inscripto', '', '', '', '', '2014-07-31 16:04:22', 0, '0000-00-00 00:00:00', NULL, 1),
(15, 'Raimundo Moujan', 'raimundo-moujan', '', '', '', '1133721370', '', '', '', '2014-07-31 15:48:00', 0, '0000-00-00 00:00:00', NULL, 0),
(40, 'El Perro en la Luna SRL', 'el-perro-en-la-luna-srl', '', '30-71047810-0', '', '47805657', 'O´Higgins 2653', 'info@elperroenlaluna.com.ar', '', '2014-08-08 14:40:56', 0, '0000-00-00 00:00:00', NULL, 1),
(14, 'Martin Rodriguez', 'martin-rodriguez', '', '', '', '1160221409', '', 'mateofederal@hotmail.com', '', '2014-07-31 15:39:51', 0, '0000-00-00 00:00:00', NULL, 0),
(12, 'Fernando Salem', 'fernando-salem', '', '', '', '', '', '', '', '2014-07-30 20:37:01', 0, '0000-00-00 00:00:00', NULL, 1),
(21, 'Georgina Pretto', 'georgina-pretto', '', '', '', '', '', '', '', '2014-07-31 16:06:35', 0, '0000-00-00 00:00:00', NULL, 0),
(22, 'Berenice Arguello', 'berenice-arguello', '', '', '', '', '', '', '', '2014-07-31 16:06:53', 0, '0000-00-00 00:00:00', NULL, 1),
(23, 'Leandro Ferrer ', 'leandro-ferrer-', '', '', '', '', '', '', '', '2014-07-31 16:07:18', 0, '0000-00-00 00:00:00', NULL, 0),
(24, 'Claudio Pedreira', 'claudio-pedreira', '', '', '', '', '', '', '', '2014-07-31 16:07:51', 0, '0000-00-00 00:00:00', NULL, 1),
(25, 'Rayuela ', 'rayuela-', '', '', '', '', '', '', '', '2014-07-31 16:08:00', 0, '0000-00-00 00:00:00', NULL, 0),
(26, 'Tomas Ambranson', 'tomas-ambranson', '', '', '', '', '', '', '', '2014-07-31 16:13:36', 0, '0000-00-00 00:00:00', NULL, 1),
(27, 'Fernando Salem ', 'fernando-salem-', '', '', '', '', '', '', '', '2014-07-31 16:27:55', 0, '0000-00-00 00:00:00', NULL, 1),
(29, 'Adrian Nallim', 'adrian-nallim', '', '', '', '', '', '', '', '2014-08-01 09:50:27', 0, '0000-00-00 00:00:00', NULL, 1),
(30, 'Raimundo Moujan', 'raimundo-moujan', '', '', '', '', '', '', '', '2014-08-01 09:56:03', 0, '0000-00-00 00:00:00', NULL, 0),
(39, 'MOLLICA FERNANDO EMILIANO', 'mollica-fernando-emiliano', '', '20-20282094-9', '', '154423-3556', 'O´Higgins 2653', 'fmollica@gmail.com', '', '2014-08-08 12:04:57', 0, '0000-00-00 00:00:00', NULL, 0),
(34, 'Alucine ', 'alucine-', '', '', '', '', '', '', '', '2014-08-01 10:06:41', 0, '0000-00-00 00:00:00', NULL, 1),
(41, 'Jorge Gabriel Tristan', 'jorge-gabriel-tristan', '', '20268499548', '', '1530368615', 'Deheza 2916', 'tallerbuenoscanos@gmail.com', '', '2014-08-08 15:19:32', 0, '0000-00-00 00:00:00', NULL, 0),
(42, 'Segurfilms', 'segurfilms', '', '', '', '4633-3405', 'Felipe Vallese 1751 ', 'segurfilms@gmail.com', 'www.segurfilms.com.ar', '2014-08-08 16:21:37', 0, '0000-00-00 00:00:00', NULL, 0),
(43, 'Alta Definición', 'alta-definicion', '', '', '', '', '', '', '', '2014-08-09 19:46:27', 0, '0000-00-00 00:00:00', NULL, 1),
(44, 'Leandro Piccarreta', 'leandro-piccarreta', '', '', '', '', '', '', '', '2014-08-09 19:46:58', 0, '0000-00-00 00:00:00', NULL, 0),
(45, 'TAGO', 'tago', '', '', '', '', '', '', '', '2014-08-09 19:47:15', 0, '0000-00-00 00:00:00', NULL, 0),
(46, 'Fianzas y Crédito', 'fianzas-y-credito', '', '', '', '', '', '', '', '2014-08-09 19:47:37', 0, '0000-00-00 00:00:00', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rubro`
--

DROP TABLE IF EXISTS `rubro`;
CREATE TABLE IF NOT EXISTS `rubro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=112 ;

--
-- Dumping data for table `rubro`
--

INSERT INTO `rubro` (`id`, `parent_id`, `title`) VALUES
(105, 105, 'Arte Rodaje '),
(4, 0, 'Alquiler de Equipamiento'),
(5, 4, 'Alquiler de Camara'),
(6, 0, 'Personal Tecnico de Rodaje'),
(7, 6, 'Sonidista'),
(8, 4, 'Alquiler de Luces'),
(9, 4, 'Paquete Luces'),
(10, 4, 'Cámara y accesorios Canon EOS 5D'),
(11, 4, 'Carro o slider'),
(12, 4, 'Grip / Hot Head'),
(13, 4, 'Dolly Mini Jib'),
(14, 4, 'Flat Car'),
(15, 0, 'MATERIAL VIRGEN Y LABORATORIO'),
(16, 0, 'Administración y estructura'),
(17, 32, 'Honorarios director'),
(18, 0, 'MODELOS'),
(19, 0, 'NO SINDICADOS'),
(20, 19, 'coach de actores'),
(21, 19, 'coreografo'),
(22, 19, 'secundarios'),
(23, 19, 'Bailarina'),
(24, 18, 'Castinera'),
(25, 18, 'Personaje secundarios (jornada laboral + uso todos los medios)'),
(26, 18, 'Extras'),
(27, 18, 'Pruebas de Vestuario'),
(28, 17, 'Honorarios Director'),
(29, 16, 'Caja chica'),
(30, 16, 'Envios al Exterior'),
(31, 16, 'Telefonos y Faxes'),
(32, 0, 'DIRECCIÓN'),
(33, 32, 'Dirección General'),
(34, 32, 'Director U1'),
(35, 32, 'Director U2'),
(36, 32, 'Asistente de Dirección'),
(37, 32, 'Auxiliar de Dirección'),
(38, 0, 'PRODUCCIÓN'),
(39, 38, 'Productor General'),
(40, 38, 'Jefe de Producción'),
(41, 38, 'Asistente de Producción'),
(42, 0, 'CONTENIDOS'),
(43, 42, 'Guiones'),
(44, 42, 'Asesoramiento en Contenidos'),
(83, 60, 'Locutor'),
(82, 6, 'Camarógrafo '),
(49, 49, 'Arte digital / Diseño '),
(50, 0, 'Post producción'),
(87, 50, 'Diseño de placas / animaciones'),
(52, 50, 'Director de animación'),
(53, 50, 'Animadores'),
(54, 50, 'Data manager'),
(55, 50, 'Data manager'),
(56, 50, 'Editor'),
(57, 18, 'Direccion de voces'),
(58, 18, 'voces originales'),
(59, 18, 'voces originales'),
(60, 0, 'SONIDO'),
(84, 6, 'Asistente de cámara'),
(63, 60, 'Postproducción de sonido'),
(64, 60, 'Estudio de grabación de voces'),
(65, 60, 'Música original'),
(66, 0, 'Insumos'),
(67, 66, 'DVCAM'),
(68, 66, 'DVD'),
(69, 66, 'Bienes de uso'),
(85, 6, 'Grip'),
(73, 18, 'AAA'),
(74, 18, 'AAA'),
(75, 0, 'SEGUROS'),
(76, 75, 'Accidentes Personales'),
(77, 75, 'Seguro Equipos'),
(78, 75, 'Seguro Caución'),
(79, 75, 'Responsabilidad Civil'),
(86, 60, 'Estudio de grabación'),
(88, 4, 'Sonido'),
(89, 0, 'Bienes de uso'),
(90, 89, 'Sala de edición'),
(91, 0, 'Gastos de rodaje'),
(92, 91, 'Storage'),
(93, 91, 'Gelatinas y filtros'),
(94, 91, 'Alquiler Handies'),
(95, 91, 'Comidas'),
(96, 91, 'Movilidad'),
(97, 16, 'Auxiliar administrativa'),
(99, 16, 'Mensajeria'),
(100, 16, 'Servicios varios (alquiler, servicios, etc)'),
(101, 66, 'Material Virgen '),
(102, 60, 'Musicalización'),
(106, 91, 'Utilería '),
(107, 91, 'gastos de rodaje ');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `user_migrado` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `user`
--


-- --------------------------------------------------------

--
-- Table structure for table `user_admin`
--

DROP TABLE IF EXISTS `user_admin`;
CREATE TABLE IF NOT EXISTS `user_admin` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_email` varchar(100) DEFAULT '',
  `user_password` varchar(200) NOT NULL DEFAULT '0',
  `username` varchar(30) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT '',
  `user_lastname` varchar(100) DEFAULT '',
  `user_active` int(1) NOT NULL DEFAULT '0',
  `photo_id` int(1) NOT NULL DEFAULT '0',
  `access_level` int(1) NOT NULL DEFAULT '0',
  `site_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `alias` (`username`),
  UNIQUE KEY `email` (`user_email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `user_admin`
--

INSERT INTO `user_admin` (`user_id`, `user_email`, `user_password`, `username`, `user_name`, `user_lastname`, `user_active`, `photo_id`, `access_level`, `site_id`) VALUES
(1, 'ariel@frooit.com', '6c7f6e6d6c797e736e7328', 'admin', 'Ariel', 'Velaz', 0, 0, 1, 1),
(11, 'dario@godaro.com', '666c686964787865797f', 'godaro', 'Dario', 'Aguilar', 0, 0, 1, 0),
(12, 'adrian', '666c686964787865797f', 'adrian', 'Adrian', 'Martin', 0, 0, 1, 0),
(13, 'javierF79@gmail.com', '7f7d516e6464606108', 'JavierF', 'Javier', 'Frontera', 0, 0, 1, 0),
(14, 'recepcion@elperroenlaluna.com.ar>', '3b3f3236303b3b', 'stephi', 'Stephanie ', 'Parnes', 0, 0, 1, 0),
(15, 'produccionzamba@gmail.com', '6f7d6d7b', 'zamba', 'Camila', 'Fanego', 0, 0, 1, 0),
(16, 'sm@elperroenlaluna.com.ar', '6f617167777f6476', 'ilvo', 'Sebastián ', 'Mignogna', 0, 0, 1, 0),
(17, 'cdt@elperroenluna.com.ar', '786c656b6a75', 'cdt', 'Cecilia', 'Di Tirro', 0, 0, 1, 0),
(18, 'gs@elperroenlaluna.com.ar', '3b3f323634', 'barca', 'gabriel', 'Siperman', 0, 0, 1, 0),
(19, 'eplproduccion@gmail.com', '3b3f323634', 'Silvia', 'Silvia', 'Lastra', 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_level`
--

DROP TABLE IF EXISTS `user_level`;
CREATE TABLE IF NOT EXISTS `user_level` (
  `user_level_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_level_name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_level_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user_level`
--

INSERT INTO `user_level` (`user_level_id`, `user_level_name`) VALUES
(1, 'administrator'),
(2, 'editor'),
(3, 'subeditor'),
(4, 'colaborator');
