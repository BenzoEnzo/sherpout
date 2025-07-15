package com.sherpout.server.api.training.logic;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.api.training.mapper.TrainingPlanMapper;
import com.sherpout.server.api.training.repository.TrainingPlanRepository;
import com.sherpout.server.api.user.logic.TokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TrainingPlanService {
    private final TokenService tokenService;
    private final TrainingPlanRepository trainingPlanRepository;
    private final TrainingPlanMapper trainingPlanMapper;

    public TrainingPlanDTO create(TrainingPlanDTO dto) {
        TrainingPlan entity = trainingPlanMapper.mapToEntity(dto);
        entity.setUserId(tokenService.getUserId());
        return trainingPlanMapper.mapToDTO(trainingPlanRepository.save(entity));
    }
}
