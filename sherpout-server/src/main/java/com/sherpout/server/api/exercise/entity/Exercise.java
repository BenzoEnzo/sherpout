package com.sherpout.server.api.exercise.entity;

import com.sherpout.server.api.exercise.enumerated.ExerciseDifficulty;
import com.sherpout.server.api.exercise.enumerated.ExerciseEquipment;
import com.sherpout.server.api.exercise.enumerated.Muscle;
import com.sherpout.server.commons.entity.Image;
import com.sherpout.server.commons.entity.TranslatedString;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Set;

@Getter
@Setter
@Entity
public class Exercise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride( name = "en", column = @Column(name = "name_en")),
            @AttributeOverride( name = "pl", column = @Column(name = "name_pl"))
    })
    private TranslatedString name;

    @Embedded
    @AttributeOverrides({
            @AttributeOverride( name = "en", column = @Column(name = "description_en")),
            @AttributeOverride( name = "pl", column = @Column(name = "description_pl"))
    })
    private TranslatedString description;

    private ExerciseDifficulty difficulty;

    private Muscle targetMuscle;

    @ElementCollection(targetClass = Muscle.class)
    @CollectionTable(name = "exercise_support_muscle", joinColumns = @JoinColumn(name = "exercise_id"))
    @Column(name = "muscle_id", nullable = false)
    private Set<Muscle> supportMuscles;

    @ElementCollection(targetClass = ExerciseEquipment.class)
    @CollectionTable(name = "exercise_equipment", joinColumns = @JoinColumn(name = "exercise_id"))
    @Column(name = "equipment_id", nullable = false)
    private Set<ExerciseEquipment> equipments;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "cover_id")
    private Image cover;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(
            name = "exercise_image",
            joinColumns = @JoinColumn(name = "exercise_id"),
            inverseJoinColumns = @JoinColumn(name = "image_id")
    )
    private List<Image> images;

    //TODO add video
}
