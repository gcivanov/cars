package main.retreats.controllers;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import main.retreats.models.client.Skill;
import main.retreats.models.responses.SkillDeleteListResponse;
import main.retreats.services.SkillService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("skill")
public class SkillController {
    //TODO GEORGI NOT IN USE

    private final SkillService skillService;

    public SkillController(SkillService skillService) {
        this.skillService = skillService;
    }

    @GetMapping("/all")
    public ResponseEntity<List<Skill>> getAllSkills() {
        return ResponseEntity.ok(this.skillService.getAll());
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/all/sub/{id}")
    public Set<Skill> getAllSubSkills(@PathVariable("id") Long skillId) {
        //Returns also the main skill /the skill related to the skillId param/
        return this.skillService.getAllSubSkills(skillId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/save")
    public Skill saveSkill(@RequestBody @Valid Skill skill) {
        return this.skillService.save(skill);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @DeleteMapping("/delete/{id}")
    public List<Skill> deleteSkill(@PathVariable("id") @NotNull Long id) {
        return this.skillService.delete(id);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/delete/info/{id}")
    public SkillDeleteListResponse getDeleteInfo(@PathVariable("id") @NotNull Long id) {
        return this.skillService.getDeleteListBySkill(id);
    }
}
