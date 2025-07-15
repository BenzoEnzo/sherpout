CREATE TABLE training_plan
(
    id             BIGSERIAL PRIMARY KEY,
    user_id        UUID NOT NULL,
    name_en        varchar(128) NULL,
    name_pl        varchar(128) NULL,
    description_en varchar(1024) NULL,
    description_pl varchar(1024) NULL
);

CREATE TABLE training_plan_day
(
    id               BIGSERIAL PRIMARY KEY,
    training_plan_id BIGINT NOT NULL,
    CONSTRAINT training_plan_training_plan_day_fk FOREIGN KEY (training_plan_id) REFERENCES training_plan (id) ON DELETE CASCADE
);

CREATE TABLE training_plan_exercise
(
    id                   BIGSERIAL PRIMARY KEY,
    training_plan_day_id BIGINT  NOT NULL,
    exercise_id          BIGINT  NOT NULL,
    sets                 INTEGER NOT NULL,
    CONSTRAINT exercise_training_plan_exercise_fk FOREIGN KEY (exercise_id) REFERENCES exercise (id) ON DELETE cascade,
    CONSTRAINT training_plan_day_training_plan_exercise_fk FOREIGN KEY (training_plan_day_id) REFERENCES training_plan_day (id) ON DELETE CASCADE
);