package com.sherpout.server.api.record.entity;

import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.config.security.ownership.Ownable;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@EqualsAndHashCode
public class Record implements Ownable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDateTime date;
    private Double value;
    private UUID userId;
    @ManyToOne
    private Exercise exercise;
}
