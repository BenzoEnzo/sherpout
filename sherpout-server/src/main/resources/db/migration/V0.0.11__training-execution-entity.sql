CREATE TABLE training_execution
(
    id      BIGSERIAL PRIMARY KEY,
    user_id UUID   NOT NULL,
    plan_id BIGINT NOT NULL,
    status  VARCHAR(50),
    CONSTRAINT training_execution_plan_fk FOREIGN KEY (plan_id) REFERENCES training_plan (id) ON DELETE CASCADE
);

CREATE TABLE training_execution_exercise
(
    id           BIGSERIAL PRIMARY KEY,
    execution_id BIGINT NOT NULL,
    exercise_id  BIGINT NOT NULL,
    CONSTRAINT training_execution_exercise_execution_fk FOREIGN KEY (execution_id) REFERENCES training_execution (id) ON DELETE CASCADE,
    CONSTRAINT training_execution_exercise_exercise_fk FOREIGN KEY (exercise_id) REFERENCES exercise (id) ON DELETE SET NULL
);

CREATE TABLE training_execution_set
(
    id          BIGSERIAL PRIMARY KEY,
    exercise_id BIGINT NOT NULL,
    weight      INTEGER,
    CONSTRAINT training_execution_set_exercise_fk FOREIGN KEY (exercise_id) REFERENCES training_execution_exercise (id) ON DELETE CASCADE
);