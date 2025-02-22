CREATE TABLE record (
    id BIGSERIAL PRIMARY KEY,
    date TIMESTAMP WITH TIME ZONE,
    value INTEGER NOT NULL,
    user_id UUID NOT NULL,
    exercise_id BIGINT NOT NULL,
    CONSTRAINT fk_exercise FOREIGN KEY (exercise_id) REFERENCES exercise(id) ON DELETE CASCADE
);