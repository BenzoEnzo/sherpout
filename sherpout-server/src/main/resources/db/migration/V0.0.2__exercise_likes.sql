ALTER TABLE exercise ADD likes_number int8 DEFAULT 0 NULL;

CREATE TABLE exercise_like
(
    exercise_id int8      NOT NULL,
    liked_at    timestamp NOT NULL,
    user_id     uuid      NOT NULL,
    CONSTRAINT exercise_like_pkey PRIMARY KEY (exercise_id, user_id),
    CONSTRAINT exercise_like_exercise_fk FOREIGN KEY (exercise_id) REFERENCES exercise (id)
);