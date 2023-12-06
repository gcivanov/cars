
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

insert into retreats.position(id, name, status, order_number)
values ('OW', 'owner' ,'APPROVED', 1), ('EM', 'employee', 'APPROVED', 2);
