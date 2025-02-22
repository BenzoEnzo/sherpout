package com.sherpout.server.api.record.entity;

import com.sherpout.server.api.exercise.entity.Exercise;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.ZonedDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@EqualsAndHashCode
public class Record {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private ZonedDateTime date;
    private Integer value;
    private UUID userId;
    @ManyToOne
    private Exercise exercise;
}
