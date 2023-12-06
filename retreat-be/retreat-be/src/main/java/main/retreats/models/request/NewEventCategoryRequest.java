package main.retreats.models.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class NewEventCategoryRequest {
    @NotNull
    private String name;

    private String description;
}
