package com.sherpout.server.api.training.logic;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.api.training.mapper.TrainingPlanMapper;
import com.sherpout.server.api.training.repository.TrainingPlanRepository;
import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.config.security.ownership.OwnershipGuard;
import com.sherpout.server.error.exception.UnableToFindTrainingPlanException;
import com.sherpout.server.error.model.ErrorLocationType;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TrainingPlanService {
    private final TrainingPlanUpdateHelper trainingPlanUpdateHelper;
    private final TokenService tokenService;
    private final OwnershipGuard ownershipGuard;
    private final TrainingPlanRepository trainingPlanRepository;
    private final TrainingPlanMapper trainingPlanMapper;

    public TrainingPlanDTO create(TrainingPlanDTO dto) {
        TrainingPlan entity = trainingPlanMapper.mapToEntity(dto);
        entity.setUserId(tokenService.getUserId());
        return trainingPlanMapper.mapToDTO(trainingPlanRepository.save(entity));
    }

    @Transactional
    public TrainingPlanDTO update(Long id, TrainingPlanDTO dto) {
        TrainingPlan trainingPlan = trainingPlanRepository.findById(id)
                .orElseThrow(() -> new UnableToFindTrainingPlanException(ErrorLocationType.PATH_PARAM, id));

        ownershipGuard.checkOwnership(trainingPlan);

        trainingPlanMapper.mapToUpdateEntity(dto, trainingPlan);
        trainingPlanUpdateHelper.updateDays(trainingPlan, dto.getDays());

        return trainingPlanMapper.mapToDTO(trainingPlanRepository.save(trainingPlan));
    }
}
