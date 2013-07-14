set @old_unique_checks=@@unique_checks, unique_checks=0;
set @old_foreign_key_checks=@@foreign_key_checks, foreign_key_checks=0;
set @old_sql_mode=@@sql_mode, sql_mode='traditional,allow_invalid_dates';

create schema if not exists `productdb` default character set utf8 ;
use `productdb` ;

-- -----------------------------------------------------
-- table `productdb`.`account`
-- -----------------------------------------------------
drop table if exists `productdb`.`account` ;

create  table if not exists `productdb`.`account` (
  `account_id` bigint(20) not null auto_increment ,
  `email_addr` varchar(128) null default null ,
  `salt` varchar(128) null default null ,
  `password` varchar(128) null default null ,
  `first_name` varchar(64) null default null ,
  `last_name` varchar(64) null default null ,
  `middle_name` varchar(64) null default null ,
  `account_image` blob null default null ,
  `registration_addr_id` bigint(20) not null ,
  `billing_addr_id` bigint(20) not null ,
  `status` tinyint(4) null default null ,
  `registered_country` int(11) null default null ,
  `locale_iso3` tinyint(4) null default null ,
  `currency_code_iso3` tinyint(4) null default null ,
  `created_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  `last_modified_app` tinyint(4) null default null ,
  primary key (`account_id`) ,
  unique index `email_addr_unique` (`email_addr` asc) ,
  index `fk_account_address1_idx` (`registration_addr_id` asc) ,
  index `fk_account_address2_idx` (`billing_addr_id` asc) )
engine = innodb
auto_increment = 3
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`account_marketplace`
-- -----------------------------------------------------
drop table if exists `productdb`.`account_marketplace` ;

create  table if not exists `productdb`.`account_marketplace` (
  `account_marketplace_id` bigint(20) not null ,
  `account_id` bigint(20) null default null ,
  `mp_id` tinyint(4) null default null ,
  `status` tinyint(4) null default null ,
  `mp_client_id` varchar(256) null default null ,
  `mp_client_secret_code` varchar(512) null default null ,
  `mp_token` varchar(1000) null default null ,
  `mp_token_expiry_date` datetime null default null ,
  `mp_token_response` varchar(2000) null default null ,
  `create_date` datetime null default null ,
  primary key (`account_marketplace_id`) ,
  index `fk_account_marketplace_account1_idx` (`account_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`account_subscription`
-- -----------------------------------------------------
drop table if exists `productdb`.`account_subscription` ;

create  table if not exists `productdb`.`account_subscription` (
  `account_subscription_id` bigint(20) not null ,
  `account_id` bigint(20) not null ,
  `subscription_id` int(11) null default null ,
  `subscription_type` decimal(4,0) null default null comment 'subscription_type is for monthy/yearly subscription' ,
  `start_date` datetime null default null ,
  `end_date` datetime null default null ,
  `modify_date` datetime null default null ,
  `change_who` varchar(45) null default null ,
  `create_date` datetime null default null ,
  `discount_id` int(11) not null ,
  primary key (`account_subscription_id`) ,
  index `fk_account_subscription_subscription_detail1_idx` (`subscription_id` asc) ,
  index `fk_account_subscription_account1_idx` (`account_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`address`
-- -----------------------------------------------------
drop table if exists `productdb`.`address` ;

create  table if not exists `productdb`.`address` (
  `address_id` bigint(20) not null auto_increment ,
  `use_case` tinyint(4) null default null ,
  `addr_type` tinyint(4) null default null ,
  `contact_first_name` varchar(64) null default null ,
  `contact_last_name` varchar(64) null default null ,
  `company_name` varchar(64) null default null ,
  `addr_ln1` varchar(128) null default null ,
  `addr_ln2` varchar(128) null default null ,
  `addr_ln3` varchar(128) null default null ,
  `city` varchar(64) null default null ,
  `state` varchar(64) null default null ,
  `country_code_iso3` tinyint(4) null default null ,
  `zip` varchar(32) null default null ,
  `status` tinyint(4) null default null ,
  `created_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  `account_account_id` bigint(20) not null ,
  primary key (`address_id`) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`batch_job`
-- -----------------------------------------------------
drop table if exists `productdb`.`batch_job` ;

create  table if not exists `productdb`.`batch_job` (
  `batch_job_id` bigint(20) not null ,
  `account_id` bigint(20) null default null ,
  `site_id` int(11) null default null ,
  `file_id` bigint(20) not null ,
  `file_name` varchar(256) null default null ,
  `status` tinyint(4) null default null ,
  `req_location` varchar(512) null default null ,
  `res_location` varchar(512) null default null ,
  `seller_notes` varchar(512) null default null ,
  `usecase` tinyint(4) null default null ,
  `total_records` bigint(20) null default null ,
  `processed_records` bigint(20) null default null ,
  `error_count` bigint(20) null default null ,
  `create_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  primary key (`batch_job_id`, `file_id`) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`batch_work_log`
-- -----------------------------------------------------
drop table if exists `productdb`.`batch_work_log` ;

create  table if not exists `productdb`.`batch_work_log` (
  `batch_work_log_id` bigint(20) not null ,
  `batch_id` bigint(20) not null ,
  `file_id` bigint(20) not null ,
  `account_id` bigint(20) null default null ,
  `record_id` bigint(20) null default null ,
  `request` blob null default null ,
  `response` blob null default null ,
  `status` tinyint(4) null default null ,
  `api_action` varchar(64) null default null ,
  `site_id` int(11) null default null ,
  `created_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  primary key (`batch_work_log_id`, `batch_id`, `file_id`) ,
  index `fk_batch_work_log_batch_job1_idx` (`batch_id` asc, `file_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`image`
-- -----------------------------------------------------
drop table if exists `productdb`.`image` ;

create  table if not exists `productdb`.`image` (
  `image_id` bigint(20) not null ,
  `account_id` bigint(20) null default null ,
  `image_name` varchar(64) null default null ,
  `sort_order_id` tinyint(4) null default null ,
  `ref_id` bigint(20) null default null ,
  `ref_type` tinyint(4) null default null ,
  `image_format` tinyint(4) null default null ,
  `hosted_url` varchar(1028) null default null ,
  `hash` varchar(64) null default null ,
  `size` varchar(32) null default null ,
  `last_modified_date` datetime null default null ,
  `create_date` datetime null default null ,
  primary key (`image_id`) ,
  index `fk_image_product_variation1_idx` (`ref_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`listing`
-- -----------------------------------------------------
drop table if exists `productdb`.`listing` ;

create  table if not exists `productdb`.`listing` (
  `listing_id` bigint(20) not null ,
  `title` varchar(45) null default null ,
  `ref_id` bigint(20) not null ,
  `ref_type` tinyint(4) null default null ,
  `account_id` bigint(20) null default null ,
  `shipping_policy_id` bigint(20) null default null ,
  `return_policy_id` bigint(20) null default null ,
  `location_policy_id` bigint(20) null default null ,
  `price` decimal(18,4) null default null ,
  `quantity` int(11) null default null ,
  `clasification_id` bigint(20) null default null ,
  `produce` varchar(45) null default null ,
  `create_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  `last_modified_app` varchar(45) null default null ,
  primary key (`listing_id`) ,
  index `fk_listing_merchant_product1_idx` (`ref_id` asc) ,
  index `fk_listing_return_policy1_idx` (`return_policy_id` asc) ,
  index `fk_listing_shipping_policy1_idx` (`shipping_policy_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`merchant_product`
-- -----------------------------------------------------
drop table if exists `productdb`.`merchant_product` ;

create  table if not exists `productdb`.`merchant_product` (
  `merchant_product_id` bigint(20) not null auto_increment ,
  `title` varchar(256) null default null ,
  `sku` varchar(64) null default null ,
  `account_id` bigint(20) null default null ,
  `product_code` varchar(64) null default null ,
  `product_code_type` tinyint(4) null default null ,
  `created_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  `last_modified_app` tinyint(4) null default null ,
  primary key (`merchant_product_id`) )
engine = innodb
auto_increment = 5
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`product_attribute`
-- -----------------------------------------------------
drop table if exists `productdb`.`product_attribute` ;

create  table if not exists `productdb`.`product_attribute` (
  `product_attribute_id` bigint(20) not null ,
  `attr_name` varchar(64) null default null ,
  `product_specification_id` bigint(20) null default null ,
  `attr_char_value` varchar(64) null default null ,
  `attr_num_value` decimal(18,4) null default null ,
  `attr_date_value` datetime null default null ,
  `attr_data_type` tinyint(4) null default null ,
  `last_modified_date` datetime null default null ,
  `created_date` datetime null default null ,
  primary key (`product_attribute_id`) ,
  index `fk_product_attribute_product_specification1_idx` (`product_specification_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`product_classification`
-- -----------------------------------------------------
drop table if exists `productdb`.`product_classification` ;

create  table if not exists `productdb`.`product_classification` (
  `classification_id` bigint(20) not null ,
  `classification_name` varchar(45) null default null ,
  `market_id` int(11) null default null ,
  `market_ref_id` varchar(45) null default null ,
  `create_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  `last_modified_app` tinyint(4) null default null ,
  primary key (`classification_id`) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`product_description`
-- -----------------------------------------------------
drop table if exists `productdb`.`product_description` ;

create  table if not exists `productdb`.`product_description` (
  `product_description_id` bigint(20) not null ,
  `description_name` varchar(64) null default null ,
  `product_id` bigint(20) not null ,
  `description_text` text null default null ,
  `created_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  primary key (`product_description_id`) ,
  index `fk_merchant_product_description_merchant_product1_idx` (`product_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`product_specification`
-- -----------------------------------------------------
drop table if exists `productdb`.`product_specification` ;

create  table if not exists `productdb`.`product_specification` (
  `product_specification_id` bigint(20) not null ,
  `product_id` bigint(20) not null ,
  `weight_unit` tinyint(4) null default null ,
  `weight` decimal(8,2) null default null ,
  `dimension_unit` tinyint(4) null default null ,
  `width` decimal(8,2) null default null ,
  `length` decimal(8,2) null default null ,
  `height` decimal(8,2) null default null ,
  `last_modified_date` datetime null default null ,
  `create_date` datetime null default null ,
  primary key (`product_specification_id`) ,
  index `fk_product_specification_merchant_product1_idx` (`product_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`product_variation`
-- -----------------------------------------------------
drop table if exists `productdb`.`product_variation` ;

create  table if not exists `productdb`.`product_variation` (
  `product_variations_id` bigint(20) not null ,
  `product_id` bigint(20) null default null ,
  `availble_quantity` int(11) null default null ,
  `price` decimal(18,4) null default null ,
  `last_modified_date` datetime null default null ,
  `create_date` datetime null default null ,
  primary key (`product_variations_id`) ,
  index `fk_product_variation_merchant_product1_idx` (`product_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`product_variation_details`
-- -----------------------------------------------------
drop table if exists `productdb`.`product_variation_details` ;

create  table if not exists `productdb`.`product_variation_details` (
  `product_variation_details_id` bigint(20) not null ,
  `product_variation_id` bigint(20) null default null ,
  `product_id` bigint(20) null default null ,
  `variation_name` varchar(45) null default null ,
  `variation_values` varchar(45) null default null ,
  `create_date` datetime null default null ,
  primary key (`product_variation_details_id`) ,
  index `fk_product_variation_details_product_variation1_idx` (`product_variation_id` asc) ,
index `fk_product_variation_merchant_product1_idx` (`product_id` asc) )
engine = innodb
default character set = utf8;



-- -----------------------------------------------------
-- table `productdb`.`return_policy`
-- -----------------------------------------------------
drop table if exists `productdb`.`return_policy` ;

create  table if not exists `productdb`.`return_policy` (
  `policy_id` bigint(20) not null ,
  `policy_name` varchar(45) null default null ,
  `account_id` bigint(20) null default null ,
  `return_addr_id` int(11) null default null ,
  `payer_id` int(11) null default null ,
  `return_duration` int(11) null default null ,
  `policy_details` varchar(4000) null default null ,
  `status` tinyint(4) null default null ,
  `create_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  `last_modified_app` tinyint(4) null default null ,
  primary key (`policy_id`) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`shipping_policy`
-- -----------------------------------------------------
drop table if exists `productdb`.`shipping_policy` ;

create  table if not exists `productdb`.`shipping_policy` (
  `policy_id` bigint(20) not null ,
  `policy_name` varchar(45) null default null ,
  `account_id` bigint(20) null default null ,
  `ship_type` tinyint(4) null default null ,
  `ship_service_id` int(11) null default null ,
  `ship_carrier_id` int(11) null default null ,
  `cost` decimal(18,4) null default null ,
  `status` tinyint(4) null default null ,
  `create_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  `last_modified_app` tinyint(4) null default null ,
  primary key (`policy_id`) ,
  index `fk_shipping_policy_shipping_service1_idx` (`ship_service_id` asc) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`shipping_service`
-- -----------------------------------------------------
drop table if exists `productdb`.`shipping_service` ;

create  table if not exists `productdb`.`shipping_service` (
  `shipping_service_id` int(11) not null ,
  `name` varchar(45) null default null ,
  `type` tinyint(4) null default null ,
  `site` tinyint(4) null default null ,
  `status` tinyint(4) null default null ,
  `service_category` tinyint(4) null default null ,
  `created_date` datetime null default null ,
  `last_modified_date` datetime null default null ,
  primary key (`shipping_service_id`) )
engine = innodb
default character set = utf8;


-- -----------------------------------------------------
-- table `productdb`.`subscription_detail`
-- -----------------------------------------------------
drop table if exists `productdb`.`subscription_detail` ;

create  table if not exists `productdb`.`subscription_detail` (
  `subscription_id` decimal(18,0) not null ,
  `subscription_name` varchar(64) null default null ,
  `description_code` decimal(18,0) null default null ,
  `modify_date` datetime null default null ,
  `change_who` varchar(45) null default null ,
  `create_date` datetime null default null ,
  primary key (`subscription_id`) )
engine = innodb
default character set = utf8;

use `productdb` ;


set sql_mode=@old_sql_mode;
set foreign_key_checks=@old_foreign_key_checks;
set unique_checks=@old_unique_checks;
