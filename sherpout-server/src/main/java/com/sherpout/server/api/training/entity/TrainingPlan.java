package com.sherpout.server.api.training.entity;

import com.sherpout.server.commons.entity.TranslatedString;
import com.sherpout.server.config.security.ownership.Ownable;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TrainingPlan implements Ownable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private UUID userId;

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

    @OneToMany(mappedBy = "trainingPlan", cascade = CascadeType.ALL)
    private List<TrainingPlanDay> days;
}
