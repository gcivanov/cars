
    create table account (
        active boolean default true,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table account_event (
        created_on date not null,
        fk_account bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        payment_information varchar(255),
        primary key (id)
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
        fk_account bigint,
        fk_company bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        skills_text VARCHAR(520) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee_event (
        is_owner boolean default false,
        fk_employee bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table employee_skill (
        id integer not null auto_increment,
        order_number integer not null,
        fk_employee bigint,
        fk_skill bigint not null,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event (
        created_on date not null,
        end_time date not null,
        max_participants integer,
        start_time date not null,
        status_date date not null,
        fk_cluster bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        description varchar(255) not null,
        location varchar(255),
        location_google_pin varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        type enum ('RETREAT','EVENT') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_category (
        id bigint not null auto_increment,
        parent_id bigint,
        description varchar(255),
        image_url varchar(255),
        name varchar(255) not null,
        requested_by varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_event_category (
        fk_category bigint not null,
        fk_event bigint not null,
        primary key (fk_category, fk_event)
    ) engine=InnoDB;

    create table event_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_price (
        currency varchar(3) not null,
        from_date date,
        price float(53) not null,
        to_date date,
        fk_event bigint,
        id bigint not null auto_increment,
        description varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event_rating (
        created_on date not null,
        is_blocked boolean default false,
        stars smallint,
        fk_account_event bigint not null,
        fk_employee_event bigint,
        id bigint not null auto_increment,
        comment varchar(255) not null,
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
        name enum ('USER','ORGANIZER','HELPER'),
        primary key (id)
    ) engine=InnoDB;

    create table skill (
        id bigint not null auto_increment,
        description varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table event_category 
       add constraint UKqa09esl4i1ri0ovkmhu2wxcjl unique (name);

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

    alter table account_event 
       add constraint FKksdomaf98m0b9vgieudv9kmw0 
       foreign key (fk_account) 
       references account (id);

    alter table account_event 
       add constraint FKr3kqhbf6697u8rnm8mbtsuvir 
       foreign key (fk_event) 
       references event (id);

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

    alter table employee_event 
       add constraint FKdlkivl06ui4hvn6fxks6sapbr 
       foreign key (fk_employee) 
       references employee (id);

    alter table employee_event 
       add constraint FK7onjtpxhha90pu0yla4lqk6jm 
       foreign key (fk_event) 
       references event (id);

    alter table employee_skill 
       add constraint FKi6s0di4kecwq1gmgyrbtyfx5k 
       foreign key (fk_skill) 
       references skill (id);

    alter table employee_skill 
       add constraint FKd41l2xk8liguontaqed6djkco 
       foreign key (fk_employee) 
       references employee (id);

    alter table event 
       add constraint FK8a8mcn4sdyx03rao0yo7uuvg3 
       foreign key (fk_cluster) 
       references event_cluster (id);

    alter table event_event_category 
       add constraint FK945556h5lh88snu28io780jxa 
       foreign key (fk_category) 
       references event_category (id);

    alter table event_event_category 
       add constraint FK77nrmtrj9ga8obefqoatnk8cc 
       foreign key (fk_event) 
       references event (id);

    alter table event_price 
       add constraint FKa3fvqa1byij46ol0lso4wd7tm 
       foreign key (fk_event) 
       references event (id);

    alter table event_rating 
       add constraint FKi41npbiqx3uh4a39h4wod5t5x 
       foreign key (fk_account_event) 
       references account_event (id);

    alter table event_rating 
       add constraint FKkcwp3tgf4rsjhnxa9sp5i320q 
       foreign key (fk_employee_event) 
       references employee_event (id);

    create table account (
        active boolean default true,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table account_event (
        created_on date not null,
        fk_account bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        payment_information varchar(255),
        primary key (id)
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
        fk_account bigint,
        fk_company bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        skills_text VARCHAR(520) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee_event (
        is_owner boolean default false,
        fk_employee bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table employee_skill (
        id integer not null auto_increment,
        order_number integer not null,
        fk_employee bigint,
        fk_skill bigint not null,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event (
        created_on date not null,
        end_time date not null,
        max_participants integer,
        start_time date not null,
        status_date date not null,
        fk_cluster bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        description varchar(255) not null,
        location varchar(255),
        location_google_pin varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        type enum ('RETREAT','EVENT') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_category (
        id bigint not null auto_increment,
        parent_id bigint,
        description varchar(255),
        image_url varchar(255),
        name varchar(255) not null,
        requested_by varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_event_category (
        fk_category bigint not null,
        fk_event bigint not null,
        primary key (fk_category, fk_event)
    ) engine=InnoDB;

    create table event_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_price (
        currency varchar(3) not null,
        from_date date,
        price float(53) not null,
        to_date date,
        fk_event bigint,
        id bigint not null auto_increment,
        description varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event_rating (
        created_on date not null,
        is_blocked boolean default false,
        stars smallint,
        fk_account_event bigint not null,
        fk_employee_event bigint,
        id bigint not null auto_increment,
        comment varchar(255) not null,
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
        name enum ('USER','ORGANIZER','HELPER'),
        primary key (id)
    ) engine=InnoDB;

    create table skill (
        id bigint not null auto_increment,
        description varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table event_category 
       add constraint UKqa09esl4i1ri0ovkmhu2wxcjl unique (name);

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

    alter table account_event 
       add constraint FKksdomaf98m0b9vgieudv9kmw0 
       foreign key (fk_account) 
       references account (id);

    alter table account_event 
       add constraint FKr3kqhbf6697u8rnm8mbtsuvir 
       foreign key (fk_event) 
       references event (id);

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

    alter table employee_event 
       add constraint FKdlkivl06ui4hvn6fxks6sapbr 
       foreign key (fk_employee) 
       references employee (id);

    alter table employee_event 
       add constraint FK7onjtpxhha90pu0yla4lqk6jm 
       foreign key (fk_event) 
       references event (id);

    alter table employee_skill 
       add constraint FKi6s0di4kecwq1gmgyrbtyfx5k 
       foreign key (fk_skill) 
       references skill (id);

    alter table employee_skill 
       add constraint FKd41l2xk8liguontaqed6djkco 
       foreign key (fk_employee) 
       references employee (id);

    alter table event 
       add constraint FK8a8mcn4sdyx03rao0yo7uuvg3 
       foreign key (fk_cluster) 
       references event_cluster (id);

    alter table event_event_category 
       add constraint FK945556h5lh88snu28io780jxa 
       foreign key (fk_category) 
       references event_category (id);

    alter table event_event_category 
       add constraint FK77nrmtrj9ga8obefqoatnk8cc 
       foreign key (fk_event) 
       references event (id);

    alter table event_price 
       add constraint FKa3fvqa1byij46ol0lso4wd7tm 
       foreign key (fk_event) 
       references event (id);

    alter table event_rating 
       add constraint FKi41npbiqx3uh4a39h4wod5t5x 
       foreign key (fk_account_event) 
       references account_event (id);

    alter table event_rating 
       add constraint FKkcwp3tgf4rsjhnxa9sp5i320q 
       foreign key (fk_employee_event) 
       references employee_event (id);

    create table account (
        active boolean default true,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table account_event (
        created_on date not null,
        fk_account bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        payment_information varchar(255),
        primary key (id)
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
        fk_account bigint,
        fk_company bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        skills_text VARCHAR(520) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee_event (
        is_owner boolean default false,
        fk_employee bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table employee_skill (
        id integer not null auto_increment,
        order_number integer not null,
        fk_employee bigint,
        fk_skill bigint not null,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event (
        created_on date not null,
        end_time date not null,
        max_participants integer,
        start_time date not null,
        status_date date not null,
        fk_cluster bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        description varchar(255) not null,
        location varchar(255),
        location_google_pin varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        type enum ('RETREAT','EVENT') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_category (
        id bigint not null auto_increment,
        parent_id bigint,
        description varchar(255),
        image_url varchar(255),
        name varchar(255) not null,
        requested_by varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_event_category (
        fk_category bigint not null,
        fk_event bigint not null,
        primary key (fk_category, fk_event)
    ) engine=InnoDB;

    create table event_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_price (
        currency varchar(3) not null,
        from_date date,
        price float(53) not null,
        to_date date,
        fk_event bigint,
        id bigint not null auto_increment,
        description varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event_rating (
        created_on date not null,
        is_blocked boolean default false,
        stars smallint,
        fk_account_event bigint not null,
        fk_employee_event bigint,
        id bigint not null auto_increment,
        comment varchar(255) not null,
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
        name enum ('USER','ORGANIZER','HELPER'),
        primary key (id)
    ) engine=InnoDB;

    create table skill (
        id bigint not null auto_increment,
        description varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table event_category 
       add constraint UKqa09esl4i1ri0ovkmhu2wxcjl unique (name);

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

    alter table account_event 
       add constraint FKksdomaf98m0b9vgieudv9kmw0 
       foreign key (fk_account) 
       references account (id);

    alter table account_event 
       add constraint FKr3kqhbf6697u8rnm8mbtsuvir 
       foreign key (fk_event) 
       references event (id);

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

    alter table employee_event 
       add constraint FKdlkivl06ui4hvn6fxks6sapbr 
       foreign key (fk_employee) 
       references employee (id);

    alter table employee_event 
       add constraint FK7onjtpxhha90pu0yla4lqk6jm 
       foreign key (fk_event) 
       references event (id);

    alter table employee_skill 
       add constraint FKi6s0di4kecwq1gmgyrbtyfx5k 
       foreign key (fk_skill) 
       references skill (id);

    alter table employee_skill 
       add constraint FKd41l2xk8liguontaqed6djkco 
       foreign key (fk_employee) 
       references employee (id);

    alter table event 
       add constraint FK8a8mcn4sdyx03rao0yo7uuvg3 
       foreign key (fk_cluster) 
       references event_cluster (id);

    alter table event_event_category 
       add constraint FK945556h5lh88snu28io780jxa 
       foreign key (fk_category) 
       references event_category (id);

    alter table event_event_category 
       add constraint FK77nrmtrj9ga8obefqoatnk8cc 
       foreign key (fk_event) 
       references event (id);

    alter table event_price 
       add constraint FKa3fvqa1byij46ol0lso4wd7tm 
       foreign key (fk_event) 
       references event (id);

    alter table event_rating 
       add constraint FKi41npbiqx3uh4a39h4wod5t5x 
       foreign key (fk_account_event) 
       references account_event (id);

    alter table event_rating 
       add constraint FKkcwp3tgf4rsjhnxa9sp5i320q 
       foreign key (fk_employee_event) 
       references employee_event (id);

    create table account (
        active boolean default true,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table account_event (
        created_on date not null,
        fk_account bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        payment_information varchar(255),
        primary key (id)
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
        fk_account bigint,
        fk_company bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        skills_text VARCHAR(520) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee_event (
        is_owner boolean default false,
        fk_employee bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table employee_skill (
        id integer not null auto_increment,
        order_number integer not null,
        fk_employee bigint,
        fk_skill bigint not null,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event (
        created_on date not null,
        end_time date not null,
        max_participants integer,
        start_time date not null,
        status_date date not null,
        fk_cluster bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        description varchar(255) not null,
        location varchar(255),
        location_google_pin varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        type enum ('RETREAT','EVENT') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_category (
        id bigint not null auto_increment,
        parent_id bigint,
        description varchar(255),
        image_url varchar(255),
        name varchar(255) not null,
        requested_by varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_event_category (
        fk_category bigint not null,
        fk_event bigint not null,
        primary key (fk_category, fk_event)
    ) engine=InnoDB;

    create table event_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_price (
        currency varchar(3) not null,
        from_date date,
        price float(53) not null,
        to_date date,
        fk_event bigint,
        id bigint not null auto_increment,
        description varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event_rating (
        created_on date not null,
        is_blocked boolean default false,
        stars smallint,
        fk_account_event bigint not null,
        fk_employee_event bigint,
        id bigint not null auto_increment,
        comment varchar(255) not null,
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
        name enum ('USER','ORGANIZER','HELPER'),
        primary key (id)
    ) engine=InnoDB;

    create table skill (
        id bigint not null auto_increment,
        description varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table event_category 
       add constraint UKqa09esl4i1ri0ovkmhu2wxcjl unique (name);

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

    alter table account_event 
       add constraint FKksdomaf98m0b9vgieudv9kmw0 
       foreign key (fk_account) 
       references account (id);

    alter table account_event 
       add constraint FKr3kqhbf6697u8rnm8mbtsuvir 
       foreign key (fk_event) 
       references event (id);

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

    alter table employee_event 
       add constraint FKdlkivl06ui4hvn6fxks6sapbr 
       foreign key (fk_employee) 
       references employee (id);

    alter table employee_event 
       add constraint FK7onjtpxhha90pu0yla4lqk6jm 
       foreign key (fk_event) 
       references event (id);

    alter table employee_skill 
       add constraint FKi6s0di4kecwq1gmgyrbtyfx5k 
       foreign key (fk_skill) 
       references skill (id);

    alter table employee_skill 
       add constraint FKd41l2xk8liguontaqed6djkco 
       foreign key (fk_employee) 
       references employee (id);

    alter table event 
       add constraint FK8a8mcn4sdyx03rao0yo7uuvg3 
       foreign key (fk_cluster) 
       references event_cluster (id);

    alter table event_event_category 
       add constraint FK945556h5lh88snu28io780jxa 
       foreign key (fk_category) 
       references event_category (id);

    alter table event_event_category 
       add constraint FK77nrmtrj9ga8obefqoatnk8cc 
       foreign key (fk_event) 
       references event (id);

    alter table event_price 
       add constraint FKa3fvqa1byij46ol0lso4wd7tm 
       foreign key (fk_event) 
       references event (id);

    alter table event_rating 
       add constraint FKi41npbiqx3uh4a39h4wod5t5x 
       foreign key (fk_account_event) 
       references account_event (id);

    alter table event_rating 
       add constraint FKkcwp3tgf4rsjhnxa9sp5i320q 
       foreign key (fk_employee_event) 
       references employee_event (id);

    create table account (
        active boolean default true,
        date_of_birth date not null,
        date_of_registration date not null,
        last_logged_in date,
        locked boolean default false,
        receive_news_emails bit not null,
        id bigint not null auto_increment,
        email varchar(255) not null,
        first_name varchar(255) not null,
        last_name varchar(255) not null,
        password varchar(255) not null,
        phone VARCHAR(20) not null,
        picture_url varchar(255),
        gender_type enum ('MAN','WOMAN','UNDEFINED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table account_role (
        role_id integer not null,
        account_id bigint not null,
        primary key (role_id, account_id)
    ) engine=InnoDB;

    create table account_event (
        created_on date not null,
        fk_account bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        payment_information varchar(255),
        primary key (id)
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
        fk_account bigint,
        fk_company bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        fk_position varchar(255) not null,
        skills_text VARCHAR(520) not null,
        primary key (id)
    ) engine=InnoDB;

    create table employee_event (
        is_owner boolean default false,
        fk_employee bigint,
        fk_event bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table employee_skill (
        id integer not null auto_increment,
        order_number integer not null,
        fk_employee bigint,
        fk_skill bigint not null,
        additional_information varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event (
        created_on date not null,
        end_time date not null,
        max_participants integer,
        start_time date not null,
        status_date date not null,
        fk_cluster bigint,
        id bigint not null auto_increment,
        additional_information varchar(255),
        description varchar(255) not null,
        location varchar(255),
        location_google_pin varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        type enum ('RETREAT','EVENT') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_category (
        id bigint not null auto_increment,
        parent_id bigint,
        description varchar(255),
        image_url varchar(255),
        name varchar(255) not null,
        requested_by varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_event_category (
        fk_category bigint not null,
        fk_event bigint not null,
        primary key (fk_category, fk_event)
    ) engine=InnoDB;

    create table event_cluster (
        id bigint not null auto_increment,
        additional_information varchar(255),
        name varchar(255) not null,
        primary key (id)
    ) engine=InnoDB;

    create table event_price (
        currency varchar(3) not null,
        from_date date,
        price float(53) not null,
        to_date date,
        fk_event bigint,
        id bigint not null auto_increment,
        description varchar(255),
        primary key (id)
    ) engine=InnoDB;

    create table event_rating (
        created_on date not null,
        is_blocked boolean default false,
        stars smallint,
        fk_account_event bigint not null,
        fk_employee_event bigint,
        id bigint not null auto_increment,
        comment varchar(255) not null,
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
        name enum ('USER','ORGANIZER','HELPER'),
        primary key (id)
    ) engine=InnoDB;

    create table skill (
        id bigint not null auto_increment,
        description varchar(255),
        name varchar(255) not null,
        status enum ('REQUESTED','IN_PROCESS','APPROVED','DENIED') not null,
        primary key (id)
    ) engine=InnoDB;

    alter table account 
       add constraint UKq0uja26qgu1atulenwup9rxyr unique (email);

    alter table company 
       add constraint UKniu8sfil2gxywcru9ah3r4ec5 unique (name);

    alter table company 
       add constraint UK8464qvq7pqo2r5es1ex03xsnb unique (vat_id);

    alter table confirmation_token 
       add constraint UK_lyp96dystkqn472el3ivm0xxs unique (account_id);

    alter table employee 
       add constraint UK_fuy53a03dnn3pwhqhrp2lc8pf unique (fk_account);

    alter table event_category 
       add constraint UKqa09esl4i1ri0ovkmhu2wxcjl unique (name);

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

    alter table account_event 
       add constraint FKksdomaf98m0b9vgieudv9kmw0 
       foreign key (fk_account) 
       references account (id);

    alter table account_event 
       add constraint FKr3kqhbf6697u8rnm8mbtsuvir 
       foreign key (fk_event) 
       references event (id);

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

    alter table employee_event 
       add constraint FKdlkivl06ui4hvn6fxks6sapbr 
       foreign key (fk_employee) 
       references employee (id);

    alter table employee_event 
       add constraint FK7onjtpxhha90pu0yla4lqk6jm 
       foreign key (fk_event) 
       references event (id);

    alter table employee_skill 
       add constraint FKi6s0di4kecwq1gmgyrbtyfx5k 
       foreign key (fk_skill) 
       references skill (id);

    alter table employee_skill 
       add constraint FKd41l2xk8liguontaqed6djkco 
       foreign key (fk_employee) 
       references employee (id);

    alter table event 
       add constraint FK8a8mcn4sdyx03rao0yo7uuvg3 
       foreign key (fk_cluster) 
       references event_cluster (id);

    alter table event_event_category 
       add constraint FK945556h5lh88snu28io780jxa 
       foreign key (fk_category) 
       references event_category (id);

    alter table event_event_category 
       add constraint FK77nrmtrj9ga8obefqoatnk8cc 
       foreign key (fk_event) 
       references event (id);

    alter table event_price 
       add constraint FKa3fvqa1byij46ol0lso4wd7tm 
       foreign key (fk_event) 
       references event (id);

    alter table event_rating 
       add constraint FKi41npbiqx3uh4a39h4wod5t5x 
       foreign key (fk_account_event) 
       references account_event (id);

    alter table event_rating 
       add constraint FKkcwp3tgf4rsjhnxa9sp5i320q 
       foreign key (fk_employee_event) 
       references employee_event (id);
