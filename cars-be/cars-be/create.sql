
    create table account (
        id bigint not null auto_increment,
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        id bigint not null auto_increment,
        visible boolean default true not null,
        fk_account bigint not null,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        id bigint not null auto_increment,
        fk_car_feature_category bigint not null,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        id bigint not null auto_increment,
        order_num smallint not null,
        fk_car_offer bigint,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        id bigint not null auto_increment,
        added_date date,
        fk_maker bigint not null,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        id bigint not null auto_increment,
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        id bigint not null auto_increment,
        expiry_date date,
        account_id bigint not null,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        id bigint not null auto_increment,
        fk_account bigint not null,
        fk_company bigint not null,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        id varchar(255) not null,
        order_number integer not null,
        description varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);

    create table account (
        active boolean default true not null,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false not null,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED'),
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table admin (
        visible boolean default true not null,
        fk_account bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table car_feature (
        fk_car_feature_category bigint not null,
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_feature_category (
        id bigint not null auto_increment,
        name varchar(60) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_image (
        order_num smallint not null,
        fk_car_offer bigint,
        id bigint not null auto_increment,
        url varchar(600) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_maker (
        id bigint not null auto_increment,
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_model (
        added_date date,
        fk_maker bigint not null,
        id bigint not null auto_increment,
        model varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer (
        active bit not null,
        currency varchar(3) not null,
        kilometers integer not null,
        price float(53) not null,
        price_now float(53),
        price_to float(53),
        rating_of_five float(53),
        seats smallint,
        start_price float(53),
        year integer not null,
        end_date datetime(6) not null,
        fk_admin bigint not null,
        fk_car_model bigint not null,
        fk_cluster bigint not null,
        id bigint not null auto_increment,
        publish_date datetime(6) not null,
        views bigint default 0 not null,
        color_info varchar(50),
        engine_info varchar(50),
        model_info varchar(50),
        carfax_link varchar(220),
        additional_info varchar(500),
        publisher_url varchar(600) not null,
        delivery_info varchar(255),
        location varchar(255),
        drive_type enum ('A','F','R','U') not null,
        fuel_type enum ('G','D','H','E','PI_H','FF','O') not null,
        offer_status enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN' not null,
        start_code_type enum ('RD','SS','SY'),
        transmission_type enum ('A','M','U') not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table car_offer_feature (
        fk_car_feature bigint not null,
        fk_car_offer bigint not null,
        primary key (fk_car_feature, fk_car_offer)
    ) engine=InnoDB;

    create table company (
        id bigint not null auto_increment,
        additional_information varchar(255),
        address varchar(255) not null,
        company_number varchar(255) not null,
        description varchar(255),
        log_url varchar(255),
        mol varchar(255),
        name varchar(255) not null,
        phone VARCHAR(20) not null,
        vat_id varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table confirmation_token (
        expiry_date date,
        account_id bigint not null,
        id bigint not null auto_increment,
        token varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee (
        fk_account bigint not null,
        fk_company bigint not null,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table position (
        order_number integer not null,
        description varchar(255),
        id varchar(255) not null,
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table role (
        id integer not null auto_increment,
        name enum ('USER','DEALER','ADMIN'),
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table admin 
       add constraint UK_2e0rjo8pn03c9uqwvardw03pe unique (fk_account);

    alter table car_maker 
       add constraint UK86ciet3ivg604j403q7vbnobs unique (name);

    alter table car_offer_cluster 
       add constraint UKlp41axbaam08dhs42d2qxtar0 unique (name);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table position 
       add constraint UKqe48lxuex3swuovou3giy8qpk unique (name);

    alter table position 
       add constraint UK5lelkqkwqtfg5u42u2rh3ujl unique (order_number);

    alter table role 
       add constraint UK8sewwnpamngi6b1dwaa88askk unique (name);

    alter table account_role 
       add constraint FKrs2s3m3039h0xt8d5yhwbuyam 
       foreign key (role_id) 
       references role (id);

    alter table account_role 
       add constraint FK1f8y4iy71kb1arff79s71j0dh 
       foreign key (account_id) 
       references account (id);

    alter table admin 
       add constraint FKcg8110dwmnxgt812m2o83om6i 
       foreign key (fk_account) 
       references account (id);

    alter table car_feature 
       add constraint FK6notycwrtbx3kyejo4m08sw5b 
       foreign key (fk_car_feature_category) 
       references car_feature_category (id);

    alter table car_image 
       add constraint FK27pen87kgvmhu8yoany0fd7qs 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table car_model 
       add constraint FKkkdycgm8tvj55td4tyjd4ojt1 
       foreign key (fk_maker) 
       references car_maker (id);

    alter table car_offer 
       add constraint FKhbli3fvo8rn22qnqqeyrvg08n 
       foreign key (fk_admin) 
       references admin (id);

    alter table car_offer 
       add constraint FKc9kqxk96gqtijos2mbi5x2huo 
       foreign key (fk_cluster) 
       references car_offer_cluster (id);

    alter table car_offer 
       add constraint FKnvqmq6v8d7pfgtl3kyda562ey 
       foreign key (fk_car_model) 
       references car_model (id);

    alter table car_offer_feature 
       add constraint FK9urmfyijhs426cappo1faxp4g 
       foreign key (fk_car_feature) 
       references car_feature (id);

    alter table car_offer_feature 
       add constraint FK7e3whch9iuy5789us3a4f0ntq 
       foreign key (fk_car_offer) 
       references car_offer (id);

    alter table confirmation_token 
       add constraint FKh665h9dopriepwsv009ovyjic 
       foreign key (account_id) 
       references account (id);

    alter table employee 
       add constraint FKnbdcjjsjgrsfe8cmhasyjvvya 
       foreign key (fk_account) 
       references account (id);

    alter table employee 
       add constraint FKde1frdfeijlx07ug1cqt1bycm 
       foreign key (fk_company) 
       references company (id);

    alter table employee 
       add constraint FKgb564flit281r7gy9ogp93cod 
       foreign key (fk_position) 
       references position (id);
