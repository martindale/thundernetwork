-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               5.6.21-log - MySQL Community Server (GPL)
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             9.2.0.4947
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Struktur von Tabelle bitnet.channels
DROP TABLE IF EXISTS `channels`;
CREATE TABLE IF NOT EXISTS `channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pub_key_client` varchar(500) DEFAULT NULL,
  `pub_key_server` varchar(500) DEFAULT NULL,
  `change_address_server` varchar(500) DEFAULT NULL,
  `change_address_client` varchar(500) DEFAULT NULL,
  `master_priv_key_client` varchar(500) DEFAULT NULL,
  `master_priv_key_server` varchar(500) DEFAULT NULL,
  `initial_amount_server` bigint(20) DEFAULT NULL,
  `initial_amount_client` bigint(20) DEFAULT NULL,
  `amount_server` bigint(20) DEFAULT NULL,
  `amount_client` bigint(20) DEFAULT NULL,
  `timestamp_open` int(11) DEFAULT NULL,
  `timestamp_close` int(11) DEFAULT NULL,
  `timestamp_force_close` int(11) DEFAULT NULL,
  `key_chain_depth` int(11) DEFAULT NULL,
  `key_chain_child` int(11) DEFAULT NULL,
  `master_chain_depth` int(11) DEFAULT NULL,
  `opening_tx_hash` varchar(500) DEFAULT NULL,
  `opening_tx` int(11) DEFAULT NULL,
  `refund_tx_server` int(11) DEFAULT NULL,
  `refund_tx_client` int(11) DEFAULT NULL,
  `channel_tx_server` int(11) DEFAULT NULL,
  `channel_tx_revoke_server` int(11) DEFAULT NULL,
  `channel_tx_client` int(11) DEFAULT NULL,
  `channel_tx_revoke_client` int(11) DEFAULT NULL,
  `channel_tx_server_temp` int(11) DEFAULT NULL,
  `channel_tx_client_temp` int(11) DEFAULT NULL,
  `channel_tx_revoke_client_temp` int(11) DEFAULT NULL,
  `channel_tx_revoke_server_temp` int(11) DEFAULT NULL,
  `has_open_payments` tinyint(4) DEFAULT NULL,
  `establish_phase` tinyint(4) DEFAULT NULL,
  `payment_phase` tinyint(4) DEFAULT NULL,
  `is_ready` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle bitnet.channels: ~0 rows (ungefähr)
DELETE FROM `channels`;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle bitnet.constants
DROP TABLE IF EXISTS `constants`;
CREATE TABLE IF NOT EXISTS `constants` (
  `key_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle bitnet.constants: ~1 rows (ungefähr)
DELETE FROM `constants`;
/*!40000 ALTER TABLE `constants` DISABLE KEYS */;
INSERT INTO `constants` (`key_count`) VALUES
	(164);
/*!40000 ALTER TABLE `constants` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle bitnet.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` text NOT NULL,
  `message` longtext NOT NULL,
  `timestamp` int(11) NOT NULL,
  `pubkey` varchar(100) NOT NULL,
  `signature` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle bitnet.messages: ~0 rows (ungefähr)
DELETE FROM `messages`;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle bitnet.outputs
DROP TABLE IF EXISTS `outputs`;
CREATE TABLE IF NOT EXISTS `outputs` (
  `transaction_hash` varchar(100) DEFAULT NULL,
  `vout` int(11) DEFAULT NULL,
  `value` bigint(20) DEFAULT NULL,
  `private_key` varchar(100) DEFAULT NULL,
  `transaction_output` varchar(100) DEFAULT NULL,
  `timestamp_locked` int(11) DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle bitnet.outputs: ~0 rows (ungefähr)
DELETE FROM `outputs`;
/*!40000 ALTER TABLE `outputs` DISABLE KEYS */;
/*!40000 ALTER TABLE `outputs` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle bitnet.payments
DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id_sender` int(11) NOT NULL,
  `channel_id_receiver` int(11) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `phase` tinyint(4) NOT NULL,
  `include_in_sender_channel` tinyint(4) NOT NULL,
  `include_in_receiver_channel` tinyint(4) NOT NULL,
  `secret_hash` varchar(500) NOT NULL,
  `secret` varchar(500) DEFAULT NULL,
  `settlement_tx_sender` int(11) DEFAULT NULL,
  `settlement_tx_sender_temp` int(11) DEFAULT NULL,
  `refund_tx_sender` int(11) DEFAULT NULL,
  `refund_tx_sender_temp` int(11) DEFAULT NULL,
  `add_tx_sender` int(11) DEFAULT NULL,
  `add_tx_sender_temp` int(11) DEFAULT NULL,
  `settlement_tx_receiver` int(11) DEFAULT NULL,
  `settlement_tx_receiver_temp` int(11) DEFAULT NULL,
  `refund_tx_receiver` int(11) DEFAULT NULL,
  `refund_tx_receiver_temp` int(11) DEFAULT NULL,
  `add_tx_receiver` int(11) DEFAULT NULL,
  `add_tx_receiver_temp` int(11) DEFAULT NULL,
  `timestamp_created` int(11) NOT NULL,
  `timestamp_added_to_receiver` int(11) NOT NULL,
  `timestamp_settled` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle bitnet.payments: ~0 rows (ungefähr)
DELETE FROM `payments`;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle bitnet.storedkeys
DROP TABLE IF EXISTS `storedkeys`;
CREATE TABLE IF NOT EXISTS `storedkeys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) DEFAULT NULL,
  `owner` tinyint(4) DEFAULT NULL,
  `pub_key` varchar(60) NOT NULL,
  `priv_key` varchar(60) DEFAULT NULL,
  `current_channel` tinyint(4) DEFAULT NULL,
  `used` tinyint(4) DEFAULT NULL,
  `exposed` tinyint(4) DEFAULT NULL,
  `key_chain_depth` int(11) DEFAULT NULL,
  `key_chain_child` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pub_key` (`pub_key`),
  KEY `channel_pub_key` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle bitnet.storedkeys: ~0 rows (ungefähr)
DELETE FROM `storedkeys`;
/*!40000 ALTER TABLE `storedkeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `storedkeys` ENABLE KEYS */;


-- Exportiere Struktur von Tabelle bitnet.transactions
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(500) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `data` mediumblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Exportiere Daten aus Tabelle bitnet.transactions: ~0 rows (ungefähr)
DELETE FROM `transactions`;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
