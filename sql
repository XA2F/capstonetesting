v1
CREATE TABLE USER_TYPES(
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(5) NOT NULL,
    CONSTRAINT PK_USER_TYPES PRIMARY KEY (id)
);

CREATE TABLE USERS(
    sales_id VARCHAR(20) NOT NULL,
    user_type_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    preferred_name VARCHAR(50) NOT NULL,
    CONSTRAINT PK_USERS PRIMARY KEY (sales_id),
    CONSTRAINT FK_USERS_USER_TYPES FOREIGN KEY (user_type_id) REFERENCES USER_TYPES (id)
);

CREATE TABLE AMENITY_TYPES(
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(30) NOT NULL,
    recommended_duration INT NOT NULL,
    max_duration INT NOT NULL,
    CONSTRAINT PK_AMENITY_TYPES PRIMARY KEY (id)
);

CREATE TABLE AMENITIES (
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(20) NOT NULL,
    amenity_type_id INT NOT NULL,
    description VARCHAR(100) NOT NULL,
    location VARCHAR(50) NOT NULL,
    CONSTRAINT PK_AMENITIES PRIMARY KEY (id),
    CONSTRAINT FK_AMENITIES_AMENITY_TYPES FOREIGN KEY (amenity_type_id) REFERENCES AMENITY_TYPES (id)
);

CREATE TABLE STATUS (
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(10) NOT NULL,
    CONSTRAINT PK_STATUS PRIMARY KEY (id)
);

CREATE TABLE RESERVATIONS (
    id INT AUTO_INCREMENT NOT NULL,
    confirmation_number VARCHAR(20) NOT NULL,
    amenity_id INT NOT NULL,
    user_id VARCHAR(20) NOT NULL,
    reservation_date date NOT NULL,
    start_time time NOT NULL,
    end_time time NOT NULL,
    status_id INT NOT NULL,
    CONSTRAINT PK_RESERVATIONS PRIMARY KEY (id),
    CONSTRAINT FK_RESERVATIONS_AMENITIES FOREIGN KEY (amenity_id) REFERENCES AMENITIES (id),
    CONSTRAINT FK_RESERVATIONS_USERID FOREIGN KEY (user_id) REFERENCES USERS (sales_id),
    CONSTRAINT FK_RESERVATIONS_STATUSID FOREIGN KEY (status_id) REFERENCES STATUS (id)
);

CREATE TABLE WAITLIST (
    id INT AUTO_INCREMENT NOT NULL,
    user_id VARCHAR(20) NOT NULL,
    amenity_type_id INT NOT NULL,
    reservation_date date NOT NULL,
    start_time time NOT NULL,
    end_time time NOT NULL,
    status_id INT NOT NULL,
    CONSTRAINT PK_WAITLIST PRIMARY KEY (id),
    CONSTRAINT FK_WAITLIST_USERS FOREIGN KEY (user_id) REFERENCES USERS (sales_id),
    CONSTRAINT FK_WAITLIST_AMENITY_TYPES FOREIGN KEY (amenity_type_id) REFERENCES AMENITY_TYPES (id),
    CONSTRAINT FK_WAITLIST_STATUS FOREIGN KEY (status_id) REFERENCES STATUS (id)
);






v2



INSERT INTO USER_TYPES
    (name) VALUES
    ('USER'),
    ('ADMIN');

INSERT INTO USERS
    (sales_id, user_type_id, name, email, preferred_name) VALUES
    ('1234567', (select id from USER_TYPES where name = 'USER'), 'JimBob', 'JimBob@JimBobMail.com', 'Jimmy'),
    ('7654321', (select id from USER_TYPES where name = 'USER'), 'Horkheimer', 'Horkheimer@gmail.com', 'Harry'),
    ('9876543', (select id from USER_TYPES where name = 'ADMIN'), 'Rocky Balboa', null, 'Rock'),
    ('4562387', (select id from USER_TYPES where name = 'ADMIN'), 'Ivan Drago', 'drago@russia.com', 'Ivan');

INSERT INTO AMENITY_TYPES
    (name, recommended_duration, max_duration) VALUES
    ('massage chair', 15, 30),
    ('ping pong table', 15, 60),
    ('sleeping pod', 60, 400),
    ('air hockey table', 15, 30),
    ('shower room', 5, 45),
    ('arcade game', 15, 30);

INSERT INTO AMENITIES
    (name, amenity_type_id, description, location) VALUES
    ('massage chair 1',(select id from AMENITY_TYPES where name = 'massage chair'), 'totally awesome chair', 'floor 11 nw'),
    ('massage chair 2',(select id from AMENITY_TYPES where name = 'massage chair'), 'worst massage chair', 'floor 13 s'),
    ('air hockey table 3', (select id from AMENITY_TYPES where name = 'air hockey table'), 'super fun air hockey table','floor 22 n'),
    ('sleeping pod 5', (select id from AMENITY_TYPES where name = 'sleeping pod'), 'sleepiest sleep pod','floor 13 s'),
    ('arcade game 2', (select id from AMENITY_TYPES where name = 'arcade game'), 'funnest game ever','floor 22 sw');

INSERT INTO STATUS
    (name) VALUES
    ('RESERVED'),
    ('NOTIFIED'),
    ('WAITING');

INSERT INTO RESERVATIONS
    (confirmation_number, amenity_id, user_id, reservation_date, start_time, end_time, status_id) VALUES
    ('12345', (select id from AMENITIES where name = 'arcade game 2'),
        '1234567', '2023-10-13', '14:00:00', '14:30:00', (select id from STATUS where name = 'RESERVED'));

INSERT INTO WAITLIST
    (user_id, amenity_type_id, reservation_date, start_time, end_time, status_id) VALUES
    ('7654321', (select id from AMENITY_TYPES where name = 'sleeping pod'), '2023-11-24', '12:00:00', '13:00:00',
        (select id from STATUS where name = 'WAITING'));
