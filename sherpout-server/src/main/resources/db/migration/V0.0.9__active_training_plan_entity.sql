CREATE TABLE active_training_plan (
                                      user_id          UUID PRIMARY KEY,
                                      training_plan_id BIGINT NOT NULL REFERENCES training_plan (id) ON DELETE CASCADE,
                                      activated_at     TIMESTAMP NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX uq_active_training_plan_plan_id
    ON active_training_plan (training_plan_id);