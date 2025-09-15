CREATE TABLE assigned_training_plan (                                        id               BIGSERIAL PRIMARY KEY,
                                        assigned_user_id UUID        NOT NULL,
                                        assigned_date    DATE        NOT NULL DEFAULT CURRENT_DATE,
                                        training_plan_id BIGINT      NOT NULL,

                                        CONSTRAINT fk_assigned_training_plan_training_plan
                                            FOREIGN KEY (training_plan_id)
                                                REFERENCES training_plan (id)
                                                ON DELETE CASCADE,

                                        CONSTRAINT uq_assigned_training_plan UNIQUE (training_plan_id, assigned_user_id)
);