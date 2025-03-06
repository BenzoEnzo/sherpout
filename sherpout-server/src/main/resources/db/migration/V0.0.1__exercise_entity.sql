CREATE TABLE image
(
    id         bigserial PRIMARY KEY,
    image_data oid     NOT NULL
);

CREATE TABLE exercise
(
    id             bigserial PRIMARY KEY,
    name_en        varchar(128) NULL,
    name_pl        varchar(128) NULL,
    description_en varchar(1024) NULL,
    description_pl varchar(1024) NULL,
    difficulty     int4 NOT NULL,
    target_muscle  int4 NOT NULL,
    cover_id       bigint NULL,
    CONSTRAINT exercise_image_fk FOREIGN KEY (cover_id) REFERENCES image (id) ON DELETE SET NULL
);

CREATE TABLE exercise_equipment
(
    exercise_id  bigserial NOT NULL,
    equipment_id int4 NOT NULL,
    CONSTRAINT exercise_equipment_pk PRIMARY KEY (exercise_id, equipment_id),
    CONSTRAINT exercise_equipment_exercise_fk FOREIGN KEY (exercise_id) REFERENCES exercise (id)
);

CREATE TABLE exercise_support_muscle
(
    exercise_id bigserial NOT NULL,
    muscle_id   int4 NOT NULL,
    CONSTRAINT exercise_support_muscle_pk PRIMARY KEY (exercise_id, muscle_id),
    CONSTRAINT exercise_support_muscle_exercise_fk FOREIGN KEY (exercise_id) REFERENCES exercise (id)
);

CREATE TABLE exercise_image
(
    exercise_id bigserial NOT NULL,
    image_id    bigserial NOT NULL,
    CONSTRAINT exercise_image_pk PRIMARY KEY (exercise_id, image_id),
    CONSTRAINT exercise_image_exercise_fk FOREIGN KEY (exercise_id) REFERENCES exercise (id),
    CONSTRAINT exercise_image_image_fk FOREIGN KEY (image_id) REFERENCES image (id)
);