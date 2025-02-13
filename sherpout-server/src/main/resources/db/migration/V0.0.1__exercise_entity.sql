CREATE TABLE public.image
(
    id         bigserial NOT NULL,
    image_data bytea     NOT NULL,
    CONSTRAINT image_pk PRIMARY KEY (id)
);

CREATE TABLE public.exercise
(
    name_en        varchar(128) NULL,
    name_pl        varchar(128) NULL,
    description_en varchar(1024) NULL,
    description_pl varchar(1024) NULL,
    difficulty     int4 NULL,
    target_muscle  int4 NULL,
    id             uuid NOT NULL,
    cover_id       uuid NULL,
    CONSTRAINT exercise_pk PRIMARY KEY (id),
    CONSTRAINT exercise_image_fk FOREIGN KEY (cover_id) REFERENCES public.image (id)
);

CREATE TABLE public.exercise_equipment
(
    exercise_id  uuid NULL,
    equipment_id int4 NULL,
    CONSTRAINT exercise_equipment_exercise_fk FOREIGN KEY (exercise_id) REFERENCES public.exercise (id)
);

CREATE TABLE public.exercise_support_muscle
(
    exercise_id uuid NULL,
    muscle_id   int4 NULL,
    CONSTRAINT exercise_support_muscle_exercise_fk FOREIGN KEY (exercise_id) REFERENCES public.exercise (id)
);

CREATE TABLE public.exercise_image
(
    exercise_id uuid NULL,
    image_id    uuid NULL,
    CONSTRAINT exercise_image_exercise_fk FOREIGN KEY (exercise_id) REFERENCES public.exercise (id),
    CONSTRAINT exercise_image_image_fk FOREIGN KEY (image_id) REFERENCES public.image (id)
);