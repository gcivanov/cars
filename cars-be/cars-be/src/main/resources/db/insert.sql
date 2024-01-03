
insert into event_category(name, status, requested_by)
values  ('Astrology', 'APPROVED', 'own@own.own'),
        ('Energy practices', 'APPROVED', 'own@own.own'),
        ('Women`s energy practices', 'APPROVED', 'own@own.own'),
        ('Arts and creativity', 'APPROVED', 'own@own.own'),
        ('Yoga', 'APPROVED', 'own@own.own'),
        ('Constellations', 'APPROVED', 'own@own.own'),
        ('Meditations', 'APPROVED', 'own@own.own'),
        ('Trauma processing', 'APPROVED', 'own@own.own'),
        ('Psychology', 'APPROVED', 'own@own.own'),
        ('Tantra', 'APPROVED', 'own@own.own'),
        ('Others', 'APPROVED', 'own@own.own');


insert into role(name)
values ('USER'), ('ORGANIZER'), ('HELPER');

insert into position(id, name, status, order_number)
values ('OW', 'owner' ,'APPROVED', 1), ('EM', 'employee', 'APPROVED', 2);

insert into cars.car_maker(id, name)
 select id, name from cars_base.car_maker;

insert into cars.car_model(id, fk_maker, model)
 select id, fk_maker, model from cars_base.car_model;

------------------------------------------------------------------




insert into role(name)
values ('USER'),('DEALER'),('ADMIN');

insert into cars.position(id, name, status, order_number)
values ('OW', 'owner' ,'APPROVED', 1), ('EM', 'employee', 'APPROVED', 2);

select * from cars.car_maker;
insert into cars.car_maker(id, name)
 select id, name from cars_base.car_maker;

select * from cars.car_model;
insert into cars.car_model(id, fk_maker, model)
 select id, fk_car, model from cars_base.car_model;

select * from cars.car_offer;
select * from cars.car_feature;

-- added indexes

ALTER TABLE `car_offer`
	ADD INDEX `offer_main_index` (`fk_car_model`, `active`, `end_date`);


-- history car_offers - todo EVERY TIME replace NEW.* and OLD.* with the columns which are
-- https://www.guillermocava.com/is-there-a-mysql-option-feature-to-track-history-of-changes-to-records/


CREATE TABLE car_offer_history LIKE car_offer;
ALTER TABLE car_offer_history MODIFY id bigint NOT NULL;
ALTER TABLE car_offer_history ADD action VARCHAR(8) DEFAULT 'insert' FIRST;
ALTER TABLE car_offer_history ADD revision int NOT NULL AUTO_INCREMENT AFTER action, ADD KEY(revision);
ALTER TABLE car_offer_history DROP PRIMARY KEY, ADD PRIMARY KEY (id, revision);
ALTER TABLE car_offer_history ADD dt_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER revision;

DROP TRIGGER IF EXISTS car_offer_history_ai;
CREATE TRIGGER car_offer_history_ai AFTER INSERT ON car_offer FOR EACH ROW
    INSERT INTO car_offer_history SELECT 'insert', NULL, NOW(),
NEW.id ,
NEW.active ,
NEW.currency ,
NEW.kilometers ,
NEW.price ,
NEW.price_now ,
NEW.price_to ,
NEW.rating_of_five ,
NEW.seats ,
NEW.start_price ,
NEW.year ,
NEW.end_date ,
NEW.fk_admin ,
NEW.fk_car_model ,
NEW.fk_cluster ,
NEW.publish_date  ,
NEW.views ,
NEW.color_info ,
NEW.engine_info ,
NEW.model_info ,
NEW.carfax_link ,
NEW.additional_info ,
NEW.publisher_url ,
NEW.delivery_info ,
NEW.location ,
NEW.drive_type ,
NEW.fuel_type ,
NEW.offer_status ,
NEW.start_code_type ,
NEW.transmission_type;

DROP TRIGGER IF EXISTS car_offer_history_au;
CREATE TRIGGER car_offer_history_au AFTER UPDATE ON car_offer FOR EACH ROW
    INSERT INTO car_offer_history SELECT 'update', NULL, NOW(),
NEW.id ,
NEW.active ,
NEW.currency ,
NEW.kilometers ,
NEW.price ,
NEW.price_now ,
NEW.price_to ,
NEW.rating_of_five ,
NEW.seats ,
NEW.start_price ,
NEW.year ,
NEW.end_date ,
NEW.fk_admin ,
NEW.fk_car_model ,
NEW.fk_cluster ,
NEW.publish_date  ,
NEW.views ,
NEW.color_info ,
NEW.engine_info ,
NEW.model_info ,
NEW.carfax_link ,
NEW.additional_info ,
NEW.publisher_url ,
NEW.delivery_info ,
NEW.location ,
NEW.drive_type ,
NEW.fuel_type ,
NEW.offer_status ,
NEW.start_code_type ,
NEW.transmission_type ;

DROP TRIGGER IF EXISTS car_offer_history_bd;
CREATE TRIGGER car_offer_history_bd BEFORE DELETE ON car_offer FOR EACH ROW
    INSERT INTO car_offer_history SELECT 'delete', NULL, NOW(),
OLD.id ,
OLD.active ,
OLD.currency ,
OLD.kilometers ,
OLD.price ,
OLD.price_now ,
OLD.price_to ,
OLD.rating_of_five ,
OLD.seats ,
OLD.start_price ,
OLD.year ,
OLD.end_date ,
OLD.fk_admin ,
OLD.fk_car_model ,
OLD.fk_cluster ,
OLD.publish_date  ,
OLD.views ,
OLD.color_info ,
OLD.engine_info ,
OLD.model_info ,
OLD.carfax_link ,
OLD.additional_info ,
OLD.publisher_url ,
OLD.delivery_info ,
OLD.location ,
OLD.drive_type ,
OLD.fuel_type ,
OLD.offer_status ,
OLD.start_code_type ,
OLD.transmission_type ;


-- Admin data admin@aa.aa @dm1N0pEnL@n3
INSERT INTO `account`
VALUES (1,1,'2017-12-03','2024-01-03','2024-01-03',0,_binary '\0','admin@aa.aa','Main',
'Admin','$2a$10$kNo4xTQV0KRNyCvW02gAsuGvOKX1A/oPzk/zyud/vhznHLHtLEVNa','+3590000000',NULL,'MAN');
insert into admin(fk_account) values (1);
