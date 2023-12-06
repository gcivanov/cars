package main.retreats.models.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SearchSkillRequest {

    @NotNull
    private Long fkSkill;

    private String skillName;

    public SearchSkillRequest(SearchSkillRequest ssr) {
        this.setFkSkill(ssr.getFkSkill());
        this.setSkillName(ssr.getSkillName());
    }
}
