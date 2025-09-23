alter table active_training_plan
add constraint fk_atp_tp
foreign key (training_plan_id) references training_plan(id)
on delete cascade;

