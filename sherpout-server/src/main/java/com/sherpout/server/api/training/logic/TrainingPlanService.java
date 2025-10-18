package com.sherpout.server.api.training.logic;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.dto.TrainingPlanListDTO;
import com.sherpout.server.api.training.entity.ActiveTrainingPlan;
import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.api.training.mapper.TrainingPlanMapper;
import com.sherpout.server.api.training.repository.ActiveTrainingPlanRepository;
import com.sherpout.server.api.training.repository.TrainingPlanRepository;
import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.config.security.ownership.OwnershipGuard;
import com.sherpout.server.error.exception.UnableToFindTrainingPlanException;
import com.sherpout.server.error.model.ErrorLocationType;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class TrainingPlanService {
    private final TrainingPlanUpdateHelper trainingPlanUpdateHelper;
    private final TokenService tokenService;
    private final OwnershipGuard ownershipGuard;
    private final TrainingPlanRepository trainingPlanRepository;
    private final TrainingPlanMapper trainingPlanMapper;
    private final ActiveTrainingPlanRepository activeTrainingPlanRepository;

    public TrainingPlanDTO create(TrainingPlanDTO dto) {
        TrainingPlan entity = trainingPlanMapper.mapToEntity(dto);
        entity.setUserId(tokenService.getUserId());
        return trainingPlanMapper.mapToDTO(trainingPlanRepository.save(entity));
    }

    //TODO set last used when training execution complete
    public List<TrainingPlanListDTO> getAll() {
        return trainingPlanRepository.findAllByUserId(tokenService.getUserId()).stream()
                .map(trainingPlanMapper::mapToListDTO)
                .toList();
    }

    public TrainingPlanDTO getById(Long id) {
        TrainingPlan trainingPlan = trainingPlanRepository.findById(id)
                .orElseThrow(() -> new UnableToFindTrainingPlanException(ErrorLocationType.PATH_PARAM, id));

        ownershipGuard.checkOwnership(trainingPlan);

        return trainingPlanMapper.mapToDTO(trainingPlan);
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

    @Transactional
    public void activateTrainingPlan(Long id){
        TrainingPlan trainingPlan = trainingPlanRepository.findById(id)
                .orElseThrow(() -> new UnableToFindTrainingPlanException(ErrorLocationType.PATH_PARAM, id));

        ownershipGuard.checkOwnership(trainingPlan);
        UUID userId = trainingPlan.getUserId();

        ActiveTrainingPlan activeTrainingPlan = new ActiveTrainingPlan(userId, trainingPlan);
        activeTrainingPlanRepository.save(activeTrainingPlan);
    }

    public void delete(Long id){
        TrainingPlan trainingPlan = trainingPlanRepository.findById(id)
                .orElseThrow(() -> new UnableToFindTrainingPlanException(ErrorLocationType.PATH_PARAM, id));

        ownershipGuard.checkOwnership(trainingPlan);
        trainingPlanRepository.delete(trainingPlan);
    }
}
