package com.sherpout.server.api.training.plan.repository;

import com.sherpout.server.api.training.plan.entity.ActiveTrainingPlan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ActiveTrainingPlanRepository extends JpaRepository<ActiveTrainingPlan, UUID> {
}
