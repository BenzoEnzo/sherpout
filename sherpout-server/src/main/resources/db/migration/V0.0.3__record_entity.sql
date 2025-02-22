CREATE TABLE record (
    id BIGSERIAL PRIMARY KEY,
    date TIMESTAMP WITH TIME ZONE,
    value INTEGER,
    user_id UUID,
    exercise_id BIGINT,
    CONSTRAINT fk_exercise FOREIGN KEY (exercise_id) REFERENCES exercise(id) ON DELETE CASCADE
);