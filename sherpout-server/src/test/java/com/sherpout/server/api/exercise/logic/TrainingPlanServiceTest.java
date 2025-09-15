package com.sherpout.server.api.exercise.logic;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.api.training.logic.TrainingPlanService;
import com.sherpout.server.api.training.mapper.TrainingPlanMapper;
import com.sherpout.server.api.training.repository.TrainingPlanRepository;
import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.error.exception.UnableToFindTrainingPlanException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TrainingPlanServiceTest {

    @Mock
    private TokenService tokenService;

    @Mock
    private TrainingPlanRepository trainingPlanRepository;

    @Mock
    private TrainingPlanMapper trainingPlanMapper;

    @InjectMocks
    private TrainingPlanService trainingPlanService;

    private UUID userId;
    private Long planId;

    @BeforeEach
    void setUp() {
        userId = UUID.randomUUID();
        planId = 42L;
    }

    @Test
    void assignToUserExists() {
        TrainingPlan plan = spy(new TrainingPlan());
        plan.setId(planId);

        TrainingPlanDTO dto = new TrainingPlanDTO();
        when(trainingPlanRepository.findById(planId))
                .thenReturn(Optional.of(plan));
        when(trainingPlanRepository.save(any(TrainingPlan.class)))
                .thenAnswer(inv -> inv.getArgument(0));
        when(trainingPlanMapper.mapToDTO(any(TrainingPlan.class)))
                .thenReturn(dto);

        TrainingPlanDTO result = trainingPlanService.assignToUser(userId, planId);

        assertThat(result).isSameAs(dto);
    }

    @Test
    void assignToUserNotFound() {
        when(trainingPlanRepository.findById(planId)).thenReturn(Optional.empty());

        assertThrows(UnableToFindTrainingPlanException.class,
                () -> trainingPlanService.assignToUser(userId, planId));

        verify(trainingPlanRepository, never()).save(any());
        verifyNoInteractions(trainingPlanMapper);
    }

    @Test
    void createShouldPersistTrainingPlanWithCurrentUserAndReturnDto() {
        TrainingPlanDTO inputDto = new TrainingPlanDTO();
        TrainingPlan entity = new TrainingPlan();
        TrainingPlan savedEntity = new TrainingPlan();
        savedEntity.setId(42L);
        savedEntity.setUserId(userId);
        TrainingPlanDTO outputDto = new TrainingPlanDTO();
        outputDto.setId(42L);

        when(tokenService.getUserId()).thenReturn(userId);
        when(trainingPlanMapper.mapToEntity(inputDto)).thenReturn(entity);
        when(trainingPlanRepository.save(entity)).thenReturn(savedEntity);
        when(trainingPlanMapper.mapToDTO(savedEntity)).thenReturn(outputDto);


        TrainingPlanDTO result = trainingPlanService.create(inputDto);

        assertEquals(outputDto, result);
    }
}

